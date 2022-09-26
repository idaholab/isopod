#include "OptimizationReporter.h"
#include "GriddedData.h"

//registerMooseObject("isopodApp", OptimizationReporter);

// this is a base class but is only called in a testing input file
registerMooseObject("isopodTestApp", OptimizationReporter);

InputParameters
OptimizationReporter::validParams()
{
  InputParameters params = OptimizationData::validParams();
  params.addClassDescription("Base class for optimization reporter communication.");
  params.addRequiredParam<std::vector<ReporterValueName>>(
      "parameter_names", "List of parameter names, one for each group of parameters.");
  params.addParam<std::vector<dof_id_type>>(
      "num_values",
      "Number of parameter values associated with each parameter group in 'parameter_names'.");
  params.addParam<std::vector<Real>>("initial_condition",
                                     "Initial condition for each parameter values, default is 0.");
  params.addParam<std::vector<FileName>>("parameter_file_names",
                                         "file with parameters values and its spatio-temporal "
                                         "distribution, e.g. (x, y, z, t, value).");
  params.addParam<std::vector<Real>>(
      "lower_bounds", std::vector<Real>(), "Lower bounds for each parameter value.");
  params.addParam<std::vector<Real>>(
      "upper_bounds", std::vector<Real>(), "Upper bounds for each parameter value.");

  return params;
}

OptimizationReporter::OptimizationReporter(const InputParameters & parameters)
  : OptimizationData(parameters),
    _parameter_names(getParam<std::vector<ReporterValueName>>("parameter_names")),
    _nparam(_parameter_names.size()),
    _lower_bounds(getParam<std::vector<Real>>("lower_bounds")),
    _upper_bounds(getParam<std::vector<Real>>(
        "upper_bounds")) // vector since each parameter may have its own upper_bounds
{
  if (isParamValid("parameter_file_names")) // this could be more than one file (file for storage modulus
                                       // and another one for loss modulus)
    readParametersFromFile();
  else // if the user input the initial parameters using initial_condition then take them from the
       // input file.
    readParametersFromInput();
}
void
OptimizationReporter::readParametersFromFile()
{
    /*parse the file of the parameters, unit test it and see if this works*/
  unsigned int dim;
  std::vector<int> axes;
  std::vector<std::vector<Real>> grid;
  std::vector<Real> fcn;
  std::vector<unsigned int> step; //are we going to use this anywhere here?
  std::vector<FileName> file_names;
  file_names.reserve(_nparam); //initialize the file_names vector, the number of files should be = _nparam
  _parameters.reserve(_nparam);
  _nvalues.reserve(_nparam);
  file_names = getParam<std::vector<FileName>>("parameter_file_names"); // we may have multiple files, one for storage and another one for the loss modulus
  unsigned int v = 0;
  // loop over the available files, assignes the values and the girds to the corresponding parameter name.
  for (size_t i = 0; i < _nparam; ++i)
  {
    // initialize
    dim = 0;
    axes.resize(0);
    grid.resize(0);
    fcn.resize(0);
    //parse the file
    GriddedData::parse(dim, axes, grid, fcn, step, file_names[i]);
    _nvalues[i]=fcn.size();
    //fill-in the data corresponding to each parameter
      _parameters.push_back(
          &declareValueByName<std::vector<Real>>(_parameter_names[i], REPORTER_MODE_REPLICATED));
      _parameters[i]->assign(fcn.begin() + v,
                             fcn.begin() + v + _nvalues[i]);
      v += _nvalues[i];
  }
  _ndof = std::accumulate(_nvalues.begin(), _nvalues.end(), 0);
  _misfit_values.resize(_measurement_values.size(), 0.0);
}

void
OptimizationReporter::readParametersFromInput()
{
  _nvalues = getParam<std::vector<dof_id_type>>("num_values");
  _ndof = std::accumulate(_nvalues.begin(), _nvalues.end(), 0);
  /*parse the input file to take the parameters, unit test it and see if this works*/
  if (_parameter_names.size() != _nvalues.size())
    paramError("num_parameters",
               "There should be a number in 'num_parameters' for each name in 'parameter_names'.");

  std::vector<Real> initial_condition = isParamValid("initial_condition")
                                            ? getParam<std::vector<Real>>("initial_condition")
                                            : std::vector<Real>(_ndof, 0.0);
  if (initial_condition.size() != _ndof)
    paramError("initial_condition",
               "Initial condition must be same length as the total number of parameter values.");

  if (_upper_bounds.size() > 0 && _upper_bounds.size() != _ndof)
    paramError("upper_bounds", "Upper bound data is not equal to the total number of parameters.");
  else if (_lower_bounds.size() > 0 && _lower_bounds.size() != _ndof)
    paramError("lower_bounds", "Lower bound data is not equal to the total number of parameters.");
  else if (_lower_bounds.size() != _upper_bounds.size())
    paramError((_lower_bounds.size() == 0 ? "upper_bounds" : "lower_bounds"),
               "Both upper and lower bounds must be specified if bounds are used");

  _parameters.reserve(_nparam);
  unsigned int v = 0;
  for (unsigned int i = 0; i < _parameter_names.size(); ++i)
  {
    _parameters.push_back(
        &declareValueByName<std::vector<Real>>(_parameter_names[i], REPORTER_MODE_REPLICATED));
    _parameters[i]->assign(initial_condition.begin() + v,
                           initial_condition.begin() + v + _nvalues[i]);
    v += _nvalues[i];
  }

  _misfit_values.resize(_measurement_values.size(), 0.0);
}

void
OptimizationReporter::setInitialCondition(libMesh::PetscVector<Number> & x)
{
  x.init(_ndof);

  dof_id_type n = 0;
  for (const auto & param : _parameters)
    for (const auto & val : *param)
      x.set(n++, val);

  x.close();
}

void
OptimizationReporter::updateParameters(const libMesh::PetscVector<Number> & x)
{
  dof_id_type n = 0;
  for (auto & param : _parameters)
    for (auto & val : *param)
      val = x(n++);
}

std::vector<Real>
OptimizationReporter::computeDefaultBounds(Real val)
{
  std::vector<Real> vec;
  vec.resize(_nparam);
  for (auto i : index_range(vec))
    vec[i] = val;
  return vec;
}

Real
OptimizationReporter::computeAndCheckObjective(bool multiapp_passed)
{
  if (!multiapp_passed)
    mooseError("Forward solve multiapp failed!");
  return computeObjective();
}

Real
OptimizationReporter::computeObjective()
{
  for (size_t i = 0; i < _measurement_values.size(); ++i)
    _misfit_values[i] = _simulation_values[i] - _measurement_values[i];

  Real val = 0;
  for (auto & misfit : _misfit_values)
    val += misfit * misfit;

  val = 0.5 * val;

  return val;
}

void
OptimizationReporter::setMisfitToSimulatedValues()
{
  for (size_t i = 0; i < _measurement_values.size(); ++i)
    _misfit_values[i] = _simulation_values[i];
}

void
OptimizationReporter::setSimuilationValuesForTesting(std::vector<Real> & data)
{
  _simulation_values.clear();
  _simulation_values = data;
}
