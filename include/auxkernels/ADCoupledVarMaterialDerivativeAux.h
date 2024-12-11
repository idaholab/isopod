//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#pragma once

#include "AuxiliarySystem.h"
#include "AuxKernel.h"
#include "MaterialProperty.h"
#include "MooseTypes.h"

/**
 * Computes the derivative of a material property with respect to a coupled variable using
 * automatic differentiation.
 */
class ADCoupledVarMaterialDerivativeAux : public AuxKernel
{
public:
  static InputParameters validParams();

  ADCoupledVarMaterialDerivativeAux(const InputParameters & parameters);

protected:
  virtual Real computeValue() override;

  /// The coupled variable we are taking the derivative with respect to
  const MooseVariable & _coupled_var;

  /// AD material for the derivate dM/du
  const ADMaterialProperty<Real> & _ad_prop;
};
