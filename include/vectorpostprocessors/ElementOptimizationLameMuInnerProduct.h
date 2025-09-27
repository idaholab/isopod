//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#pragma once

#include "ElementOptimizationFunctionInnerProduct.h"

class ElementOptimizationLameMuInnerProduct : public ElementOptimizationFunctionInnerProduct
{
public:
  static InputParameters validParams();

  ElementOptimizationLameMuInnerProduct(const InputParameters & parameters);

protected:
  virtual Real computeQpInnerProduct() override;
  /// Base name of the material system
  const std::string _base_name;
  /// Holds forward strain at current quadrature points
  const MaterialProperty<RankTwoTensor> & _forward_strain;
  /// Holds adjoint strain at current quadrature points
  const MaterialProperty<RankTwoTensor> & _adjoint_strain;
};
