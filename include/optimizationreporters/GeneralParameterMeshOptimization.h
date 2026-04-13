//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#pragma once

#include "ParameterMeshOptimization.h"

class ParameterMesh;

/**
 * Mesh-based parameter optimization
 */
class GeneralParameterMeshOptimization : public ParameterMeshOptimization
{

public:
  static InputParameters validParams();
  GeneralParameterMeshOptimization(const InputParameters & parameters);

  virtual Real computeObjective() override;

protected:
  /// Reporter that will hold the objective value
  Real & _objective_val;
};
