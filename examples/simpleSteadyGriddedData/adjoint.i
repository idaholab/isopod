[Mesh]
  [gmg]
    type = GeneratedMeshGenerator
    dim = 2
    nx = 20
    ny = 25
    xmin = -1
    xmax = 1
    ymin = -1
    ymax = 1.5
  []
[]

[Problem]
  extra_tag_vectors = 'ref'
[]

[AuxVariables]
  [residual_src]
  []
[]

[AuxKernels]
  [residual_src]
    type = TagVectorAux
    vector_tag = 'ref'
    v = 'u'
    variable = 'residual_src'
  []
[]


[Variables]
  [u]
  []
[]

[Kernels]
  [diff]
    type = Diffusion
    variable = u
  []
[]

[BCs]
  [dirichlet]
    type = DirichletBC
    variable = u
    boundary = 'left right top bottom'
    value = 0
  []
[]

[Reporters]
  [measured_data]
    type = OptimizationData
    measurement_file = syntheticNodal.csv
    file_xcoord = x
    file_ycoord = y
    file_zcoord = z
    file_value = u
  []
  [gridData]
    type = GriddedDataReporter
    data_file = 'gridded_source_params.txt'
    outputs = none
  []
[]

[DiracKernels]
  [misfit]
    type = VectorPointSource
    variable = u
    value = measured_data/misfit_values
    coord_x = measured_data/measurement_xcoord
    coord_y = measured_data/measurement_ycoord
    coord_z = measured_data/measurement_zcoord
    extra_vector_tags = 'ref'
  []
[]

[Functions]
  [source]
    type = PiecewiseMultilinearFromReporter
    # type = PiecewiseMulticonstantFromReporter
    # direction = 'right right'
    values_name = 'gridData/parameter'
    grid_name = 'gridData/grid'
    axes_name = 'gridData/axes'
    step_name = 'gridData/step'
    dim_name = 'gridData/dim'
  []
[]

[VectorPostprocessors]
  [adjoint]
    type = ElementOptimizationSourceFunctionInnerProduct
    variable = u
    function = source
  []
[]

[Executioner]
  type = Steady
  solve_type = NEWTON
  line_search=none
  petsc_options_iname = '-pc_type'
  petsc_options_value = 'lu'
[]

[Outputs]
  console = false
[]
