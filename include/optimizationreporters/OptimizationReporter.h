#pragma once

#include "OptimizationReporterBase.h"

class OptimizationReporter : public OptimizationReporterBase
{
public:
  static InputParameters validParams();
  OptimizationReporter(const InputParameters & parameters);

  void initialize() override final {}
  void execute() override final {}
  void finalize() override final {}

  /**
   * Function to initialize petsc vectors from vpp data
   * FIXME: this should be const
   */
  void setInitialCondition(libMesh::PetscVector<Number> & param) override;

  /**
   * Functions to get and check bounds
   */
  bool hasBounds() const override { return _upper_bounds.size() > 0 && _lower_bounds.size() > 0; }
  const std::vector<Real> & getUpperBounds() const override { return _upper_bounds; };
  const std::vector<Real> & getLowerBounds() const override { return _lower_bounds; };
  /**
   * Function to compute default bounds when user did not provide bounds
   */
  std::vector<Real> computeDefaultBounds(Real val) override;

  /**
   * Function to get the total number of parameters
   */
  unsigned int getNumParams() override { return _ndof; };

protected:
  /// Parameter names
  const std::vector<ReporterValueName> & _parameter_names;
  /// Number of parameter vectors
  const unsigned int _nparam;
  /// Number of values for each parameter
  const std::vector<dof_id_type> & _nvalues;
  /// Total number of parameters
  const dof_id_type _ndof;

  /// Parameter values declared as reporter data
  std::vector<std::vector<Real> *> _parameters;

  /// Bounds of the parameters
  const std::vector<Real> & _lower_bounds;
  const std::vector<Real> & _upper_bounds;

  /**
   * Function to set parameters.
   * This is the first function called in objective/gradient/hessian routine
   */
  virtual void updateParameters(const libMesh::PetscVector<Number> & x) override;
};
