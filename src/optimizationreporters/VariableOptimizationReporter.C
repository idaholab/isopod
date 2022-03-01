#include "VariableOptimizationReporter.h"

#include "SystemBase.h"

registerMooseObject("isopodApp", VariableOptimizationReporter);

InputParameters
VariableOptimizationReporter::validParams()
{
  InputParameters params = OptimizationReporterBase::validParams();
  params.addClassDescription("Class for variable optimization reporter communication.");

  params.addRequiredParam<VariableName>("parameter_variable",
                                        "The variable representing the parameter to be optimized.");

  params.addParam<Real>("initial_value", 0.0, "Initial value if the parameter.");

  params.addRequiredParam<std::vector<Real>>(
      "measurement_values",
      "Measurement values collected from locations given by measurement_points");
  params.addRequiredParam<std::vector<Point>>(
      "measurement_points", "Point locations corresponding to each measurement value");

  return params;
}

VariableOptimizationReporter::VariableOptimizationReporter(const InputParameters & parameters)
  : OptimizationReporterBase(parameters),
    _var_name(parameters.getMooseType("parameter_variable")),
    _init_val(getParam<Real>("initial_value"))
{
  _misfit_values.resize(_measurement_values.size(), 0.0);
}

void
VariableOptimizationReporter::initialize()
{
  if (!_fe_problem.hasVariable(_var_name))
    mooseError("Variable ", _var_name, " does not exist in the system.");

  _param = &_fe_problem.getVariable(_tid, _var_name);

  _ndof = _param->sys().solution().size();
}

void
VariableOptimizationReporter::setInitialCondition(libMesh::PetscVector<Number> & x)
{
  x.init(_ndof);
  for (unsigned int i = 0; i < _ndof; ++i)
    x.set(i, _init_val);
}

void
VariableOptimizationReporter::updateParameters(const libMesh::PetscVector<Number> & x)
{
  for (unsigned int i = 0; i < _ndof; ++i)
    _param->sys().solution().set(i, x(i));

  _param->sys().solution().close();
  _param->sys().update();

  // std::cout << "Solution = " << _param->sys().solution() << std::endl;
}
