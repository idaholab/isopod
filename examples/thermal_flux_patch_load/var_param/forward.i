[Mesh]
  [fmg]
    type = FileMeshGenerator
    file = ./../halfSphere.e
  []
[]

[Variables]
  [temperature]
  []
[]

[AuxVariables]
  [saved_t]
    order = FIRST
    family = LAGRANGE
  []
  [p_var_forward]
    order = FIRST
    family = LAGRANGE
  []
[]

[Kernels]
  [heat_conduction]
    type = ADHeatConduction
    variable = temperature
    save_in = saved_t
  []
[]

[BCs]
  [round]
    type = ConvectiveFluxFunction
    boundary = round
    variable = temperature
    coefficient = 0.05
    T_infinity = 100.0
  []
  [bottom]
    type = CoupledVarNeumannBC
    variable = temperature
    boundary = flat
    v = p_var_forward
  []
[]

[Postprocessors]
  [p_max]
    type = ElementExtremeValue
    variable = p_var_forward
    value_type = max
    execute_on = 'INITIAL LINEAR'
  []
  [p_min]
    type = ElementExtremeValue
    variable = p_var_forward
    value_type = min
    execute_on = 'INITIAL LINEAR'
  []
  [T_max]
    type = ElementExtremeValue
    variable = temperature
    value_type = max
    execute_on = 'INITIAL LINEAR'
  []
  [T_min]
    type = ElementExtremeValue
    variable = temperature
    value_type = min
    execute_on = 'INITIAL LINEAR'
  []
[]

[Materials]
  [steel]
    type = ADGenericConstantMaterial
    prop_names = thermal_conductivity
    prop_values = 5
  []
[]

[Problem] #do we need this
  type = FEProblem
[]

[Executioner]
  type = Steady
  solve_type = NEWTON
  nl_abs_tol = 1e-6
  nl_rel_tol = 1e-8
  petsc_options_iname = '-pc_type -pc_factor_mat_solver_package'
  petsc_options_value = 'lu       superlu_dist'
  nl_forced_its = 1
[]

[VectorPostprocessors]
  #-----every forward problem should have these two
  [data_pt]
    type = VppPointValueSampler
    variable = temperature
    reporter_name = measure_data
  []
[]

[Reporters]
  [measure_data]
    type = OptimizationData
  []
[]

[Controls]
  [parameterReceiver]
    type = ControlsReceiver
  []
[]

[Outputs]
  console = true #false
  # exodus = true
  csv = true
[]
