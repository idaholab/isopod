#include "MaterialReporterOffsetFunctionMaterial.h"
#include "MooseError.h"
#include "MooseTypes.h"
#include "libmesh/int_range.h"
#include "libmesh/libmesh_common.h"

registerMooseObject("isopodApp", MaterialReporterOffsetFunctionMaterial);
registerMooseObject("isopodApp", ADMaterialReporterOffsetFunctionMaterial);

template <bool is_ad>
InputParameters
MaterialReporterOffsetFunctionMaterialTempl<is_ad>::validParams()
{
  InputParameters params = ReporterOffsetFunctionMaterial::validParams();
  params.addClassDescription(
      "Computes the misfit and misfit gradient materials for inverse optimizations problems.");

  params.addRequiredParam<MaterialName>("sim_material",
                                        "Material that is being for the computing misfit.");
  params.addRequiredParam<ReporterName>(
      "value_name", "reporter value name.  This uses the reporter syntax <reporter>/<name>.");
  return params;
}

template <bool is_ad>
MaterialReporterOffsetFunctionMaterialTempl<is_ad>::MaterialReporterOffsetFunctionMaterialTempl(
    const InputParameters & parameters)
  : ReporterOffsetFunctionMaterialTempl<is_ad>(parameters),
    _coupled_material(this->template getGenericMaterialProperty<Real, is_ad>(
        this->template getParam<MaterialName>("sim_material"))),
    _mat_prop_gradient(
        this->template declareGenericProperty<Real, is_ad>(_prop_name + "_gradient")),
    _measurement_values(
        this->template getReporterValue<std::vector<Real>>("value_name", REPORTER_MODE_REPLICATED))
{
}

template <bool is_ad>
void
MaterialReporterOffsetFunctionMaterialTempl<is_ad>::computeQpProperties()
{
  _material[_qp] = 0.0;
  _mat_prop_gradient[_qp] = 0.0;
  auto num_pts = _read_in_points ? _points.size() : _coordx.size();
  if (!_read_in_points)
    mooseAssert((_coordx.size() == _coordy.size()) && (_coordx.size() == _coordz.size()),
                "Size of the coordinate offsets don't match.");

  mooseAssert(num_pts == _measurement_values.size(),
              "Number of offsets doesn't match the number of measurements.");

  for (const auto idx : make_range(num_pts))
  {
    const Point offset =
        _read_in_points ? _points[idx] : Point(_coordx[idx], _coordy[idx], _coordz[idx]);

    Real measurement_value = _measurement_values[idx];
    auto simulation_value = _coupled_material[_qp];

    // Compute weighting function
    Real weighting = computeOffsetFunction(offset);

    // Computed weighted misfit and gradient materials
    _material[_qp] +=
        Utility::pow<2>(weighting) * Utility::pow<2>(measurement_value - simulation_value);
    _mat_prop_gradient[_qp] -=
        2.0 * Utility::pow<2>(weighting) * (measurement_value - simulation_value);
  }
}

template class MaterialReporterOffsetFunctionMaterialTempl<true>;
template class MaterialReporterOffsetFunctionMaterialTempl<false>;
