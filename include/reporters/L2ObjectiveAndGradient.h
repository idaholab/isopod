//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#pragma once

#include "GeneralReporter.h"

/**
 * Reporter containing row sum of a vector of vectors from another Reporter
 */
class L2ObjectiveAndGradient : public GeneralReporter
{
public:
  static InputParameters validParams();

  L2ObjectiveAndGradient(const InputParameters & parameters);

  virtual void initialize() override {}
  virtual void execute() override {}
  virtual void finalize() override;

private:
  /// Reporter containing dot product
  Real & _objective;
  /// Reporter containing RHS ...
  std::vector<Real> & _adjoint_rhs;

  /// First vector in dot product
  const std::vector<Real> & _measurement;
  /// Second vector in dot product
  const std::vector<Real> & _simulation;
};
