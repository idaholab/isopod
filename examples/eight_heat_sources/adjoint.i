[Mesh]
  [gen]
    type = GeneratedMeshGenerator
    dim = 2
    nx = 100
    ny = 100
    xmax = 1
    ymax = 1
  []
[]

[Variables]
  [adjointVar]
  []
[]

[Kernels]
  [heat_conduction]
    type = ADHeatConduction
    variable = adjointVar
  []
[]

[Reporters]
  [misfit]
    type = OptimizationData
  []
[]
[DiracKernels]
  [measurementPts]
    type = ReporterPointSource
    variable = adjointVar
    x_coord_name = misfit/measurement_xcoord
    y_coord_name = misfit/measurement_ycoord
    z_coord_name = misfit/measurement_zcoord
    value_name = misfit/misfit_values
  []
[]

[BCs]
  [left]
    type = DirichletBC
    variable = adjointVar
    boundary = left
    value = 0
  []
  [right]
    type = DirichletBC
    variable = adjointVar
    boundary = right
    value = 0
  []
  [bottom]
    type = DirichletBC
    variable = adjointVar
    boundary = bottom
    value = 0
  []
  [top]
    type = DirichletBC
    variable = adjointVar
    boundary = top
    value = 0
  []
[]

[Materials]
  [steel]
    type = ADGenericConstantMaterial
    prop_names = thermal_conductivity
    prop_values = 5
  []
[]

[Executioner]
  type = Steady
  solve_type = PJFNK
  nl_abs_tol = 1e-6
  nl_rel_tol = 1e-8
  petsc_options_iname = '-pc_type -pc_hypre_type'
  petsc_options_value = 'hypre boomeramg'
[]

[VectorPostprocessors]
  [gradient]
    type = PointValueSampler
    variable = adjointVar
    points = '0.3 0.8 0
              0.3 0.6 0
              0.3 0.4 0
              0.3 0.2 0
              0.7 0.8 0
              0.7 0.6 0
              0.7 0.4 0
              0.7 0.2 0'
    sort_by = id
  []
[]

[Outputs]
  console = false
  exodus = false
  file_base = 'adjoint'
[]
