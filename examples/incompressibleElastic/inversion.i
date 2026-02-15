[Optimization]
[]

[OptimizationReporter]
  type = OptimizationReporter
  parameter_names = 'mu'
  num_values = '3'
  #initial_condition = '1.0 1.0 1.0'
  initial_condition = '0.1 0.1 0.1'
  lower_bounds = '0.1'
  upper_bounds = '10.0'
  measurement_points = '-1.0 -1.0 0.0
                        -1.0  0.0 0.0
                        -1.0  1.0 0.0
                         0.0 -1.0 0.0
                         0.0  0.0 0.0
                         0.0  1.0 0.0
                         1.0 -1.0 0.0
                         1.0  0.0 0.0
                         1.0  1.0 0.0'
  measurement_values = '4.1613567552542 5.9488957653438 7.675869730064
                        3.7517712455797 5.548762655743  7.3172699473444
                        3.5372009228108 5.3435565114703 7.156727075585'
[]

[Executioner]
  type = Optimize
  tao_solver = taobqnls #taobncg #taoblmvm
  petsc_options_iname = '-tao_gatol -tao_ls_type -tao_max_it'
  petsc_options_value = '1e-6 unit 500'

  #THESE OPTIONS ARE FOR TESTING THE ADJOINT GRADIENT
  #petsc_options_iname='-tao_max_it -tao_fd_test -tao_test_gradient -tao_fd_gradient -tao_fd_delta -tao_gatol'
  #petsc_options_value='1 true true false 1e-8 0.1'
  #petsc_options = '-tao_test_gradient_view'
  verbose = true
[]

[MultiApps]
  [forward]
    type = FullSolveMultiApp
    input_files = model_grad.i
    execute_on = FORWARD
  []
[]

[Transfers]
  [set_model_grad]
    type = MultiAppReporterTransfer
    to_multi_app = forward
    from_reporters = 'OptimizationReporter/measurement_xcoord
                      OptimizationReporter/measurement_ycoord
                      OptimizationReporter/measurement_zcoord
                      OptimizationReporter/measurement_time
                      OptimizationReporter/measurement_values
                      OptimizationReporter/mu'
    to_reporters = 'measure_data/measurement_xcoord
                    measure_data/measurement_ycoord
                    measure_data/measurement_zcoord
                    measure_data/measurement_time
                    measure_data/measurement_values
                    parametrization/mu'
  []
  [get_simulation_values]
    type = MultiAppReporterTransfer
    from_multi_app = forward
    from_reporters = 'measure_data/simulation_values'
    to_reporters = 'OptimizationReporter/simulation_values'
  []
  [get_grad_mu]
    type = MultiAppReporterTransfer
    from_multi_app = forward
    from_reporters = 'grad_mu/inner_product'
    to_reporters = 'OptimizationReporter/grad_mu'
  []
[]

[Reporters]
  [optInfo]
    type = OptimizationInfo
    items = 'current_iterate function_value gnorm'
  []
[]

[Outputs]
  console = false
  csv = true
[]
