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

[BCs]
  [left]
    type = FunctionNeumannBC
    variable = temperature
    boundary = left
    function = left_function
  []
  [right]
    type = FunctionNeumannBC
    variable = temperature
    boundary = right
    function = right_function
  []
  [bottom]
    type = DirichletBC
    variable = temperature
    boundary = bottom
    value = 200
  []
  [top]
    type = DirichletBC
    variable = temperature
    boundary = top
    value = 100
  []
[]

[Functions]
  [left_function]
    type = ParsedFunction
    value = a*1.0
    vars = 'a'
    vals = 'p1'
  []
  [right_function]
    type = ParsedFunction
    value = b*1.0
    vars = 'b'
    vals = 'p2'
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
  petsc_options_iname = '-ksp_type -pc_type -pc_factor_mat_solver_package'
  petsc_options_value = 'preonly    lu       superlu_dist'
[]

[VectorPostprocessors]
  [data_pt]
    type = VppPointValueSampler
    variable = temperature
    reporter_name = measure_data
  []
[]

[Reporters]
  [measure_data]
    type=OptimizationData
    variable = temperature
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

[Postprocessors]
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

[Controls]
  [parameterReceiver]
    type = ControlsReceiver
  []
[]

[Outputs]
  exodus = true
  file_base = 'forward'
[]
