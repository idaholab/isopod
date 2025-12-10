//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#include "CorrelationObjectiveAndGradient.h"

registerMooseObject("OptimizationApp", CorrelationObjectiveAndGradient);

InputParameters
CorrelationObjectiveAndGradient::validParams()
{
  InputParameters params = GeneralReporter::validParams();
  params.addClassDescription("Correlation objective.");
  params.addParam<std::string>(
      "objective_name", "objective", "Objective function.");
  params.addParam<std::string>(
      "adjoint_rhs_vector_name", "adjoint_rhs", "RHS for adjoint = derivative of objective with state vector.");
  params.addRequiredParam<ReporterName>("measurement_vector", "Measurement vector.");
  params.addRequiredParam<ReporterName>("simulation_vector", "Simulation vector.");
  params.set<ExecFlagEnum>("execute_on") = EXEC_TIMESTEP_END;
  return params;
}

CorrelationObjectiveAndGradient::CorrelationObjectiveAndGradient(const InputParameters & parameters)
  : GeneralReporter(parameters),
    _objective(declareValueByName<Real>(getParam<std::string>("objective_name"), REPORTER_MODE_REPLICATED)),
    _adjoint_rhs(declareValueByName<std::vector<Real>>(getParam<std::string>("adjoint_rhs_vector_name"),
                                                   REPORTER_MODE_REPLICATED)),
    _measurement(getReporterValueByName<std::vector<Real>>(getParam<ReporterName>("measurement_vector"),
                                                        REPORTER_MODE_REPLICATED)),
    _simulation(getReporterValueByName<std::vector<Real>>(getParam<ReporterName>("simulation_vector"),
                                                        REPORTER_MODE_REPLICATED))
{
}

void
CorrelationObjectiveAndGradient::finalize()
{
  std::size_t entries(_measurement.size());
  if (entries != _simulation.size())
    mooseError("Measurement and simulations vectors must be of same size.",
               "\nsize of 'measurement_vector = ",
               entries,
               "\nsize of 'simulation_vector = ",
               _simulation.size());

  _objective = 0;
  _adjoint_rhs.clear();
  _adjoint_rhs.resize(entries,0.0);
  Real ss = 0;
  Real mm = 0;
  Real ms = 0;
  for (std::size_t i = 0; i < entries; ++i)
  {
    ss += _simulation[i]*_simulation[i];
    mm += _measurement[i]*_measurement[i];
    ms += _measurement[i]*_simulation[i];
  }
  _objective = 0.5*(1.0-ms*ms/ss/mm);
  Real factor_m = ms/ss/mm;
  Real factor_s = ms*ms/ss/ss/mm;
  for (std::size_t i = 0; i < entries; ++i)
  {
    _adjoint_rhs[i] = factor_s*_simulation[i]-factor_m*_measurement[i];
  }
}
