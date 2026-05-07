//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#include "GeneralParameterMeshOptimization.h"

registerMooseObject("OptimizationApp", GeneralParameterMeshOptimization);

InputParameters
GeneralParameterMeshOptimization::validParams()
{
  InputParameters params = ParameterMeshOptimization::validParams();

  params.addClassDescription("Contains a reporter to send sub-app computed objective to.  "
                             "Otherwise, the same as ParameterMeshOptimizationComputes.");
  params.addRequiredParam<ReporterValueName>(
      "objective_name", "Preferred name of reporter value defining the objective.");

  return params;
}

GeneralParameterMeshOptimization::GeneralParameterMeshOptimization(
    const InputParameters & parameters)
  : ParameterMeshOptimization(parameters),
    _objective_val(declareValueByName<Real>(getParam<ReporterValueName>("objective_name"),
                                            REPORTER_MODE_REPLICATED))
{
}

Real
GeneralParameterMeshOptimization::computeObjective()
{
  return _objective_val;
}
