//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#include "OptimizationReporterBase.h"

InputParameters
OptimizationReporterBase::validParams()
{
  InputParameters params = OptimizationData::validParams();
  params.addClassDescription(
      "Reporter to hold measurement and simulation data for optimization problems");
  return params;
}

OptimizationReporterBase::OptimizationReporterBase(const InputParameters & parameters)
  : OptimizationData(parameters)
{
}

Real
OptimizationReporterBase::computeObjective()
{
  for (size_t i = 0; i < _measurement_values.size(); ++i)
    _misfit_values[i] = _simulation_values[i] - _measurement_values[i];

  Real val = 0;
  for (auto & misfit : _misfit_values)
    val += misfit * misfit;

  val = 0.5 * val;

  return val;
}
