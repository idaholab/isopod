#pragma once

#include "OptimizationReporterBase.h"
#include "libmesh/numeric_vector.h"

class VariableOptimizationReporter : public OptimizationReporterBase
{
public:
  static InputParameters validParams();
  VariableOptimizationReporter(const InputParameters & parameters);

  void initialize() override;
  void execute() override final {}
  void finalize() override final {}

  /**
   * Function to initialize petsc vectors from vpp data
   * FIXME: this should be const
   */
  void setInitialCondition(libMesh::PetscVector<Number> & param) override;

  /**
   * Function to check bounds
   * TODO: add bounds
   */
  bool hasBounds() const override { return false; }

  /**
   * Function to get the total number of parameters
   */
  unsigned int getNumParams() override { return _ndof; };

private:
  /// Variable name
  std::string _var_name;

  /// Reference to the variable
  MooseVariableFieldBase * _param = nullptr;

  /// Total number of parameters
  dof_id_type _ndof;

  /// Initial value
  const Real & _init_val;

  /**
   * Function to set parameters.
   * This is the first function called in objective/gradient/hessian routine
   */
  virtual void updateParameters(const libMesh::PetscVector<Number> & x) override;
};
