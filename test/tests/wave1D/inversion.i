[Optimization]
[]
[OptimizationReporter]
  type = GeneralOptimization
  parameter_names = 'G'
  num_values = 1
  initial_condition = '3.99' # Converges when initital value is in between 3.99 and 4.01, e.g. 3.95 and 4.05 diverge
                             # This is for frequencies of 1,2,3,4 (toogether) as opposed to previous frequency of 1
  lower_bounds = '1'
  upper_bounds = '10'
  #num_values = 2
  #initial_condition = '4.01 4.01'
  #lower_bounds = '1 1'
  #upper_bounds = '5 5'
  objective_name = objective
[]
[Executioner]
  type = Optimize
  tao_solver = taoblmvm
  petsc_options_iname = '-tao_gatol -tao_max_it -tao_ls_type'
  petsc_options_value = '1e-8 100 unit'
  #petsc_options_iname = '-tao_gatol -tao_max_it -tao_fd_test -tao_test_gradient -tao_fd_gradient -tao_ls_type'
  #petsc_options_value = '1e-8 1 true true false unit'
  #petsc_options = '-tao_test_gradient_view'
  verbose = true
[]
[Reporters]
  [OptimizationInfo]
    type = OptimizationInfo
    items = 'current_iterate function_value gnorm'
  []
[]
[Outputs]
  csv = true
  console = false
  file_base = inversion/
[]    
[MultiApps]
  [model_grad_sampler]
    type = FullSolveMultiApp
    input_files = 'sampler.i'
    execute_on = FORWARD
  []
[]
[Transfers]
  [SetParameters]
    type = MultiAppReporterTransfer
    to_multi_app = model_grad_sampler
    from_reporters = 'OptimizationReporter/G'
    to_reporters = 'parameters/G'
  []
  [GetObjectiveGradient]
    type = MultiAppReporterTransfer
    from_multi_app = model_grad_sampler
    from_reporters = 'objective/objective
                      gradient/gradient'
    to_reporters = 'OptimizationReporter/objective
                    OptimizationReporter/grad_G'
  []
[]
