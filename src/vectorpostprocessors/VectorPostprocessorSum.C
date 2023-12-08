//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#include "VectorPostprocessorSum.h"
#include "VectorPostprocessorInterface.h"

registerMooseObject("MooseApp", VectorPostprocessorSum);

InputParameters
VectorPostprocessorSum::validParams()
{
  InputParameters params = GeneralVectorPostprocessor::validParams();
  params.addClassDescription("Sum of two vector post-processors of equal size");
  params.addRequiredParam<VectorPostprocessorName>(
      "vectorpostprocessor_a", "The first vector post-processor");
  params.addRequiredParam<VectorPostprocessorName>(
      "vectorpostprocessor_b", "The second vector post-processor");
  params.addRequiredParam<std::string>(
      "vector_name_a", "The name of the vector in the first vector post-processor");
  params.addRequiredParam<std::string>(
      "vector_name_b", "The name of the vector in the second vector post-processor");
  params.set<ExecFlagEnum>("execute_on") = EXEC_TIMESTEP_END;

  return params;
}

VectorPostprocessorSum::VectorPostprocessorSum(const InputParameters & parameters)
  : GeneralVectorPostprocessor(parameters),
    _pp_vec(declareVector(MooseUtils::shortName(parameters.get<std::string>("_object_name")))),
    _values_a(getVectorPostprocessorValue("vectorpostprocessor_a",
                                          getParam<std::string>("vector_name_a"))),
    _values_b(getVectorPostprocessorValue("vectorpostprocessor_b",
                                          getParam<std::string>("vector_name_b")))
{
}

void
VectorPostprocessorSum::initialize()
{
  _pp_vec.clear();
}

void
VectorPostprocessorSum::execute()
{
  if (_values_a.size() != _values_b.size())
    mooseError("The  vector post-processors must have the same sizei to be summed.");
  _pp_vec.clear();
  _pp_vec.resize(_values_a.size(),0.0);
  for (unsigned int i = 0; i < _values_a.size(); ++i)
    _pp_vec[i] = _values_a[i]+_values_b[i];
}
