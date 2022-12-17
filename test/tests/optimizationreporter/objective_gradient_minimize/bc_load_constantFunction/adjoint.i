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
  [param1]
    type = ConstantReporter
    real_vector_names = 'vals'
    real_vector_values = '0' # Dummy
  []
  [param2]
    type = ConstantReporter
    real_vector_names = 'vals'
    real_vector_values = '0' # Dummy
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
    type = NeumannBC
    variable = temperature
    boundary = right
    value = 0
  []
  [bottom]
    type = DirichletBC
    variable = temperature
    boundary = bottom
    value = 0
  []
  [top]
    type = DirichletBC
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

[Functions]
  [left_function_deriv_a]
    type = ParsedOptimizationFunction
    expression = 'a'
    param_symbol_names = 'a'
    param_vector_name = 'param1/vals'
  []
  [right_function_deriv_b]
    type = ParsedOptimizationFunction
    expression = 'b'
    param_symbol_names = 'b'
    param_vector_name = 'param2/vals'
  []
[]

[VectorPostprocessors]
  [adjoint_bc_left]
    type = SideOptimizationNeumannFunctionInnerProduct
    variable = temperature
    function = left_function_deriv_a
    boundary = left
  []
  [adjoint_bc_right]
    type = SideOptimizationNeumannFunctionInnerProduct
    variable = temperature
    function = right_function_deriv_b
    boundary = right
  []
[]

[VectorPostprocessors]
  [adjoint_bc]
    type = VectorOfPostprocessors
    postprocessors = 'adjoint_bc_0 adjoint_bc_1'
   []
 []

[Outputs]
  exodus = true
  file_base = 'adjoint'
[]
