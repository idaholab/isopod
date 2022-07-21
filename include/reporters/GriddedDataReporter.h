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

class GriddedDataReporter : public GeneralReporter
{
public:
  static InputParameters validParams();

  GriddedDataReporter(const InputParameters & parameters);

  virtual void initialize() override {}
  virtual void execute() override;
  virtual void finalize() override {}

protected:
  std::vector<FileName> _file_names;
  /// Parameter coordinates (sapce and time)
  std::vector<std::vector<Real>> & _parameters;
  std::vector<std::vector<Real>> & _parameter_xcoord;
  std::vector<std::vector<Real>> & _parameter_ycoord;
  std::vector<std::vector<Real>> & _parameter_zcoord;
  std::vector<std::vector<Real>> & _parameter_time;
  // std::vector<std::vector<Real> *> _parameters;

private:
  void readParametersFromFile(const std::vector<FileName> file_names);
  void fillAxesInfo(const std::vector<std::vector<Real>> grid,
                    const std::vector<int> axes,
                    std::vector<Real> & parameter_xcoord,
                    std::vector<Real> & parameter_ycoord,
                    std::vector<Real> & parameter_zcoord,
                    std::vector<Real> & parameter_time);
};
