//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#pragma once

#include "GeneralVectorPostprocessor.h"

/**
 *  VectorPostprocessorAdd is a type of VectorPostprocessor that outputs the
 *  values of sum of two vector postprocessors
 */

class VectorPostprocessorSum : public GeneralVectorPostprocessor
{
public:
  static InputParameters validParams();

  /**
   * Class constructor
   * @param parameters The input parameters
   */
  VectorPostprocessorSum(const InputParameters & parameters);

  /**
   * Initialize, clears the postprocessor vector
   */
  virtual void initialize() override;

  /**
   * Populates the postprocessor vector of values with the supplied postprocessors
   */
  virtual void execute() override;

protected:
  /// The VectorPostprocessorValue object where the results are stored
  VectorPostprocessorValue & _pp_vec;

  const VectorPostprocessorValue & _values_a;
  const VectorPostprocessorValue & _values_b;
  Real _coef_a, _coef_b;
};
