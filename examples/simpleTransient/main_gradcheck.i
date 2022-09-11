[StochasticTools]
[]

[OptimizationReporter]
  type = ObjectiveGradientMinimize

  parameter_names = 'source'
  num_values = '44'
[]

[MultiApps]
  [forward]
    type = OptimizeFullSolveMultiApp
    input_files = forward.i
    execute_on = FORWARD
  []
  [adjoint]
    type = OptimizeFullSolveMultiApp
    input_files = adjoint.i
    execute_on = ADJOINT
  []
[]

[Transfers]
  [to_forward]
    type = MultiAppReporterTransfer
    to_multi_app = forward
    from_reporters = 'OptimizationReporter/source'
    to_reporters = 'src_values/values'
  []
  [from_forward]
    type = MultiAppReporterTransfer
    from_multi_app = forward
    from_reporters = 'measured_data/misfit_values
                      measured_data/simulation_values
                      measured_data/measurement_values
                      measured_data/measurement_time'
    to_reporters = 'OptimizationReporter/misfit_values
                      OptimizationReporter/simulation_values
                      OptimizationReporter/measurement_values
                      OptimizationReporter/measurement_time'
  []
  [to_adjoint]
    type = MultiAppReporterTransfer
    to_multi_app = adjoint
    from_reporters = 'OptimizationReporter/source
                      OptimizationReporter/misfit_values'
    to_reporters = 'src_values/values
                      measured_data/misfit_values'
  []
  [from_adjoint]
    type = MultiAppReporterTransfer
    from_multi_app = adjoint
    from_reporters = 'adjoint/inner_product'
    to_reporters = 'OptimizationReporter/adjoint'
  []
[]

[Executioner]
  type = Optimize
  solve_on = none
  tao_solver =taolmvm
  petsc_options_iname='-tao_max_it -tao_fd_test -tao_test_gradient -tao_fd_gradient -tao_fd_delta'
  petsc_options_value='1 true true false 1e-6'
  #petsc_options = '-tao_test_gradient_view'
  verbose = true
[]

[Outputs]
  [out]
    execute_system_information_on=none
    type = JSON
  []
[]
