#pragma once

#include "MooseTypes.h"
#include "ReporterOffsetFunctionMaterial.h"
#include "Function.h"

template <bool>
class MaterialReporterOffsetFunctionMaterialTempl;
typedef MaterialReporterOffsetFunctionMaterialTempl<false> MaterialReporterOffsetFunctionMaterial;
typedef MaterialReporterOffsetFunctionMaterialTempl<true> ADMaterialReporterOffsetFunctionMaterial;

/**
 * This class creates a misfit and misfit gradient material that can be used for
 * optimizing measurements weighted by functions.
 */
template <bool is_ad>
class MaterialReporterOffsetFunctionMaterialTempl
  : public ReporterOffsetFunctionMaterialTempl<is_ad>
{
public:
  static InputParameters validParams();

  MaterialReporterOffsetFunctionMaterialTempl<is_ad>(const InputParameters & parameters);

protected:
  virtual void computeQpProperties() override;

  /// Coupled Material to scale by
  const GenericMaterialProperty<Real, is_ad> & _coupled_material;

  /// Gradient of misfit with respect to the coupled_material
  GenericMaterialProperty<Real, is_ad> & _mat_prop_gradient;

  /// just the misfit unsquared, NOT SQUARED like L2
  GenericMaterialProperty<Real, is_ad> & _mat_prop_unsquared;

  /// values at each xyz coordinate
  const std::vector<Real> & _measurement_values;

  using ReporterOffsetFunctionMaterialTempl<is_ad>::_prop_name;
  using ReporterOffsetFunctionMaterialTempl<is_ad>::_qp;
  using ReporterOffsetFunctionMaterialTempl<is_ad>::_material;
  using ReporterOffsetFunctionMaterialTempl<is_ad>::_points;
  using ReporterOffsetFunctionMaterialTempl<is_ad>::_read_in_points;
  using ReporterOffsetFunctionMaterialTempl<is_ad>::_coordx;
  using ReporterOffsetFunctionMaterialTempl<is_ad>::_coordy;
  using ReporterOffsetFunctionMaterialTempl<is_ad>::_coordz;
  using ReporterOffsetFunctionMaterialTempl<is_ad>::computeOffsetFunction;
};
