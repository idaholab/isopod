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
  [src]
    type = BodyForce
    variable = u
    function = source
    extra_vector_tags = 'ref'
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

[Functions]
  [source]
    type = PiecewiseMulticonstantFromReporter
    direction = 'right right'
    values_name = 'gridData/parameter'
    grid_name = 'gridData/grid'
    axes_name = 'gridData/axes'
    step_name = 'gridData/step'
    dim_name = 'gridData/dim'
  []
[]

[Executioner]
  type = Steady
  solve_type = NEWTON
  line_search=none
  petsc_options_iname = '-pc_type'
  petsc_options_value = 'lu'
[]

[Reporters]
  [measured_data]
    type = OptimizationData
    measurement_file = syntheticNodal.csv
    file_xcoord = x
    file_ycoord = y
    file_zcoord = z
    file_value = u
    variable = u
    execute_on = timestep_end
    outputs=none
  []
  [gridData]
    type = GriddedDataReporter
    data_file = 'gridded_source_params_const.txt'
    outputs = none
  []
[]

[VectorPostprocessors]
 [line1]
   type = LineValueSampler
   start_point = '0.5 -0.9 0'
   end_point = '0.5 1.4 0'
   num_points = 5
   sort_by = id
   variable = u
 []
 [line2]
   type = LineValueSampler
   start_point = '-0.5 -0.9 0'
   end_point = '-0.5 1.4 0'
   num_points = 5
   sort_by = id
   variable = u
 []
[]

[Outputs]
  # exodus = true
  csv = true
  console = false
[]
