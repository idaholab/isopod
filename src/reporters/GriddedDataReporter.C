//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#include "GriddedDataReporter.h"
#include "DelimitedFileReader.h"
#include "GriddedData.h"

registerMooseObject("isopodApp", GriddedDataReporter);

InputParameters
GriddedDataReporter::validParams()
{
  InputParameters params = GeneralReporter::validParams();
  params.addClassDescription(
      "Reporter to hold the parameter values and its spatial and temporal coordinates");
  params.addRequiredParam<std::vector<FileName>>(
      "parameter_file_names",
      "text file for every parameter, includes the parameter values, its spatial and temporal "
      "distribution");
  return params;
}

GriddedDataReporter::GriddedDataReporter(const InputParameters & parameters)
  : GeneralReporter(parameters),
    _file_names(getParam<std::vector<FileName>>("parameter_file_names")),
    _parameters(
        declareValueByName<std::vector<std::vector<Real>>>("param", REPORTER_MODE_REPLICATED)),
    _parameter_xcoord(declareValueByName<std::vector<std::vector<Real>>>("param_xcoord",
                                                                         REPORTER_MODE_REPLICATED)),
    _parameter_ycoord(declareValueByName<std::vector<std::vector<Real>>>("param_ycoord",
                                                                         REPORTER_MODE_REPLICATED)),
    _parameter_zcoord(declareValueByName<std::vector<std::vector<Real>>>("param_zcoord",
                                                                         REPORTER_MODE_REPLICATED)),
    _parameter_time(
        declareValueByName<std::vector<std::vector<Real>>>("param_time", REPORTER_MODE_REPLICATED))
{
  readParametersFromFile(_file_names);
}

void
GriddedDataReporter::execute()
{
}

void
GriddedDataReporter::readParametersFromFile(const std::vector<FileName> file_names)
{
  unsigned int nparam = file_names.size();
  ///for each parameter; dim, axes, grid, fcn and step should be filled-in
  unsigned int dim;
  std::vector<int> axes;
  std::vector<std::vector<Real>> grid;
  std::vector<Real> fcn;
  std::vector<unsigned int> step;
  std::vector<unsigned int> nvalues;
  nvalues.resize(nparam, 0);
  _parameters.resize(nparam);
  _parameter_xcoord.resize(nparam);
  _parameter_ycoord.resize(nparam);
  _parameter_zcoord.resize(nparam);
  _parameter_time.resize(nparam);
  // loop over the available files, assignes the values and the girds to the corresponding parameter
  // name.
  for (unsigned int i = 0; i < nparam; ++i)
  {
    // initialize
    dim = 0;
    axes.resize(0);
    grid.resize(0);
    fcn.resize(0);
    // parse the file
    GriddedData::parse(dim, axes, grid, fcn, step, file_names[i]);
    // fill-in the _parameters
    _parameters[i].resize(fcn.size(), 0);
    _parameters[i] = fcn;
    // fill-in the axes information
    fillAxesInfo(grid,
                 axes,
                 _parameter_xcoord[i],
                 _parameter_ycoord[i],
                 _parameter_zcoord[i],
                 _parameter_time[i]);
  }
  ///implement some mooseError checks similar to the following
}

void
GriddedDataReporter::fillAxesInfo(const std::vector<std::vector<Real>> grid,
                                  const std::vector<int> axes,
                                  std::vector<Real> & parameter_xcoord,
                                  std::vector<Real> & parameter_ycoord,
                                  std::vector<Real> & parameter_zcoord,
                                  std::vector<Real> & parameter_time)
{
  unsigned int axis_index = 100;
  for (unsigned int i = 0; i < axes.size(); ++i)
  {
    axis_index = axes[i];
    if (axis_index == 0)
    {
      parameter_xcoord = grid[i];
      continue;
    }
    else if (parameter_xcoord.empty())
      parameter_xcoord = {}; // this axes is not inclueded in the data

    if (axis_index == 1)
    {
      parameter_ycoord = grid[i];
      continue;
    }
    else if (parameter_ycoord.empty())
      parameter_ycoord = {}; // this axes is not inclueded in the data

    if (axis_index == 2)
    {
      parameter_zcoord = grid[i];
      continue;
    }
    else if (parameter_zcoord.empty())
      parameter_zcoord = {}; // this axes is not inclueded in the data

    if (axis_index == 3)
    {
      parameter_time = grid[i];
      continue;
    }
    else if (parameter_time.empty())
      parameter_time = {}; // this axes is not inclueded in the data
  }
}
