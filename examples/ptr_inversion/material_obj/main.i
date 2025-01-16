[Optimization]
[]

[OptimizationReporter]
  type = GeneralOptimization
  objective_name = objective_value
  parameter_names = 'parameter_results'
  num_values = '1'
  # Better to have larger initial conditon than smaller. Problem can have
  # multiple solutions all on the smaller side.
  initial_condition = '1.5'
  lower_bounds = '0.0001'
[]

[Executioner]
  type = Optimize
  tao_solver = taobqnls
  petsc_options_iname = '-tao_gatol -tao_max_it  -tao_ls_type'
  petsc_options_value = '1e-6 1000 armijo'
  verbose = true
  output_optimization_iterations = true
[]

[MultiApps]
  [forward]
    type = FullSolveMultiApp
    input_files = forward_and_adjoint.i
    execute_on = "FORWARD"
  []
[]

[Transfers]
  # FORWARD transfers
  [toForward_measument]
    type = MultiAppReporterTransfer
    to_multi_app = forward
    from_reporters = 'OptimizationReporter/parameter_results'
    to_reporters = 'params/k'
  []
  [fromForward]
    type = MultiAppReporterTransfer
    from_multi_app = forward
    from_reporters = 'objective/value
                     gradient/inner'
    to_reporters = 'OptimizationReporter/objective_value
                    OptimizationReporter/grad_parameter_results'
  []
[]

[Outputs]
  [out]
    execute_system_information_on = NONE
    type = JSON
    execute_on = 'FORWARD FINAL'
  []
[]
