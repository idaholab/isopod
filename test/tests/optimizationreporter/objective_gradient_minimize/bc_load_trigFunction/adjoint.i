[Mesh]
[]

[Variables]
  [temperature]
  []
[]

[Kernels]
  [heat_conduction]
    type = HeatConduction
    variable = temperature
  []
[]

[DiracKernels]
  [pt]
    type = ReporterPointSource
    variable = temperature
    x_coord_name = misfit/measurement_xcoord
    y_coord_name = misfit/measurement_ycoord
    z_coord_name = misfit/measurement_zcoord
    value_name = misfit/misfit_values
  []
[]

[Reporters]
  [misfit]
    type=OptimizationData
  []
[]

[BCs]
  [left]
    type = NeumannBC
    variable = temperature
    boundary = left
    value = 0
  []
  [right]
    type = DirichletBC
    variable = temperature
    boundary = right
    value = 0
  []
  [bottom]
    type = NeumannBC
    variable = temperature
    boundary = bottom
    value = 0
  []
  [top]
    type = NeumannBC
    variable = temperature
    boundary = top
    value = 0
  []
[]

[Materials]
  [steel]
    type = GenericConstantMaterial
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


# from forward.i
# [Functions]
#   [sin_function]
#     type = ParsedFunction
#     value = a*sin(2*pi*b*(y+c))+d
#     vars = 'a b c d'
#     vals = '500 0.5 p1 p2'
#   []
# []

[Functions]
  [sin_deriv_c]
    type = ParsedFunction
    value = 2*pi*a*b*cos(2*pi*b*(c+y))
    vars = 'a b c'
    vals = '500 0.5 p1'
  []
  [sin_deriv_d]
    type = ParsedFunction
    value = 1.0
  []
[]

[Postprocessors]
  [adjoint_bc_0]
    type = VariableFunctionSideIntegral
    boundary = 'left top bottom'
    function = sin_deriv_c
    variable = temperature
  []
  [adjoint_bc_1]
    type = VariableFunctionSideIntegral
    boundary = 'left top bottom'
    function = sin_deriv_d
    variable = temperature
  []
  [p1]
    type = ConstantValuePostprocessor
    value = 0
    execute_on = LINEAR
  []
  [p2]
    type = ConstantValuePostprocessor
    value = 0
    execute_on = LINEAR
  []
[]

[VectorPostprocessors]
  [adjoint_bc]
    type = VectorOfPostprocessors
    postprocessors = 'adjoint_bc_0 adjoint_bc_1'
   []
 []

[Controls]
  [adjointReceiver]
    type = ControlsReceiver
  []
[]


[Outputs]
  exodus = true
  file_base = 'adjoint'
[]
