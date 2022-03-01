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
#include "OptimizationData.h"
#include "libmesh/petsc_vector.h"
#include "libmesh/petsc_matrix.h"
#include "DataIO.h"

class OptimizationReporterBase : public OptimizationData
{
public:
  static InputParameters validParams();
  OptimizationReporterBase(const InputParameters & parameters);

  void initialize() override {}
  void execute() override {}
  void finalize() override {}

  /**
   * Function to initialize petsc vectors from vpp data
   * FIXME: this should be const
   */
  virtual void setInitialCondition(libMesh::PetscVector<Number> & param) = 0;

  /**
   * Functions to get and check bounds
   */
  virtual bool hasBounds() const = 0;
  virtual const std::vector<Real> & getUpperBounds() const
  {
    mooseError("Bounds are not implemented for form function type ", _type);
  }
  virtual const std::vector<Real> & getLowerBounds() const
  {
    mooseError("Bounds are not implemented for form function type ", _type);
  }

  /**
   * Function to compute default bounds when user did not provide bounds
   */
  virtual std::vector<Real> computeDefaultBounds(Real /*val*/)
  {
    mooseError("Default bounds are not implemented for form function type ", _type);
  }
  /**
   * Function to compute objective and handle a failed solve.
   * This is the last function called in objective routine
   */
  virtual Real computeAndCheckObjective(bool solver_converged);

  /**
   * Function to compute gradient.
   * This is the last call of the gradient routine.
   */
  virtual void computeGradient(libMesh::PetscVector<Number> & /*gradient*/)
  {
    mooseError("Gradient function has not been defined for form function type ", _type);
  }

  /**
   * Function to compute gradient.
   * This is the last call of the hessian routine.
   */
  virtual void computeHessian(libMesh::PetscMatrix<Number> & /*hessian*/)
  {
    mooseError("Hessian function has not been defined for form function type ", _type);
  }

  /**
   * Function to get the total number of parameters
   */
  virtual unsigned int getNumParams() = 0;

protected:
  /**
   * Function to compute objective.
   * This is the last function called in objective routine
   */
  Real computeObjective();

  /**
   * Function to set parameters.
   * This is the first function called in objective/gradient/hessian routine
   */
  virtual void updateParameters(const libMesh::PetscVector<Number> & x) = 0;

private:
  friend class OptimizeSolve;
};
