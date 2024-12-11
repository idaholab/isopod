//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#include "ADCoupledVarMaterialDerivativeAux.h"
#include "libmesh/libmesh_common.h"

registerMooseObject("isopodApp", ADCoupledVarMaterialDerivativeAux);

InputParameters
ADCoupledVarMaterialDerivativeAux::validParams()
{
  InputParameters params = AuxKernel::validParams();
  params.addClassDescription("An auxkernel that calculates the derivative of a material "
                             "property with respect to a coupled variable.");
  params.addRequiredCoupledVar("coupled_var",
                               "The variable with respect to which the derivative is taken.");
  params.addRequiredParam<MaterialPropertyName>(
      "ad_prop_name", "The name of the material property to take the derivative of.");

  return params;
}

ADCoupledVarMaterialDerivativeAux::ADCoupledVarMaterialDerivativeAux(
    const InputParameters & parameters)
  : AuxKernel(parameters),
    _coupled_var(*getVar("coupled_var", 0)),
    _ad_prop(getADMaterialProperty<Real>(getParam<MaterialPropertyName>("ad_prop_name")))
{
  if (isNodal())
    paramError("variable", "This AuxKernel only supports Elemental fields");
}

Real
ADCoupledVarMaterialDerivativeAux::computeValue()
{
  const auto & dofs = _coupled_var.dofIndices();

  const auto & phis = _coupled_var.phi();

  auto mat_derivatives = _ad_prop[_qp].derivatives();

  Real _derivative_value = 0;

  for (const auto & dof : dofs)
  {
    for (const auto & phi : phis[_qp])
      _derivative_value += phi * mat_derivatives[dof];
  }

  return _derivative_value;
}
