# ADCoupledVarMaterialDerivativeAux

## Description

The `AuxKernel` calculates the derivative of a material property with respect to a coupled variable using automatic differentiation. This kernel is particularly useful when you need to compute the sensitivity of a material property with respect to a given variable, which can be crucial for optimization, sensitivity analysis, or other numerical studies.

## Example Input File Syntax

!listing test/tests/auxkernels/coupledmatderivative/adcoupled_mat.i

!syntax parameters /Auxkernels/ADCoupledVarMaterialDerivativeAux

!syntax inputs /Auxkernels/ADCoupledVarMaterialDerivativeAux

!syntax children /Auxkernels/ADCoupledVarMaterialDerivativeAux
