//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#include "ElementOptimizationLameMuInnerProduct.h"

registerMooseObject("OptimizationApp", ElementOptimizationLameMuInnerProduct);

InputParameters
ElementOptimizationLameMuInnerProduct::validParams()
{
  InputParameters params = ElementOptimizationFunctionInnerProduct::validParams();
  params.addClassDescription("Compute the gradient for material inversion, with respect"
                             "to Lame parameter Mu by taking the inner product of"
                             "forward and adjoint strains");
  return params;
}
ElementOptimizationLameMuInnerProduct::ElementOptimizationLameMuInnerProduct(
    const InputParameters & parameters)
  : ElementOptimizationFunctionInnerProduct(parameters),
    _base_name(isParamValid("base_name") ? getParam<std::string>("base_name") + "_" : ""),
    _adjoint_strain(getMaterialPropertyByName<RankTwoTensor>("mechanical_strain")),
    _forward_strain(getMaterialPropertyByName<RankTwoTensor>("forward_mechanical_strain"))
{
}

Real
ElementOptimizationLameMuInnerProduct::computeQpInnerProduct()
{
  Real inner_product = 0.0;
  for (const auto i : make_range(Moose::dim))
    for (const auto j : make_range(Moose::dim))
      inner_product += _forward_strain[_qp](i, j) * _adjoint_strain[_qp](i, j);

  return -2.0 * inner_product;
}
