[StochasticTools]
[]

[OptimizationReporter]
  type = ObjectiveGradientMinimize

  parameter_names = 'source'
  num_values = '24'
[]

[Executioner]
  type = Optimize
  # tao_solver = taolmvm
  # petsc_options_iname='-tao_gatol'
  # petsc_options_value='1e-3'

  tao_solver = taonls
  petsc_options_iname = '-tao_gttol -tao_nls_pc_type -tao_nls_ksp_type'
  petsc_options_value = '1e-5 none cg'

  # petsc_options = '-tao_test_gradient_view'
  # petsc_options_iname='-tao_max_it -tao_fd_test -tao_test_gradient -tao_fd_gradient -tao_fd_delta -tao_gatol'
  # petsc_options_value='1 true true false 0.0001 0.0001'

  verbose = true
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
  [homogeneous_forward]
    type = OptimizeFullSolveMultiApp
    input_files = forward.i
    execute_on = "HOMOGENEOUS_FORWARD"
  []
[]

[Transfers]
  [to_forward]
    type = MultiAppReporterTransfer
    to_multi_app = forward
    from_reporters = 'OptimizationReporter/source'
    to_reporters = 'gridData/parameter'
  []
  [from_forward]
    type = MultiAppReporterTransfer
    from_multi_app = forward
    from_reporters = 'measured_data/misfit_values
                      measured_data/simulation_values
                      measured_data/measurement_values
                      measured_data/measurement_time'
    to_reporters   = 'OptimizationReporter/misfit_values
                      OptimizationReporter/simulation_values
                      OptimizationReporter/measurement_values
                      OptimizationReporter/measurement_time'
  []

  [to_adjoint]
    type = MultiAppReporterTransfer
    to_multi_app = adjoint
    from_reporters = 'OptimizationReporter/source OptimizationReporter/misfit_values'
    to_reporters = 'gridData/parameter measured_data/misfit_values'
  []
  [from_adjoint]
    type = MultiAppReporterTransfer
    from_multi_app = adjoint
    from_reporters = 'adjoint/inner_product'
    to_reporters = 'OptimizationReporter/adjoint'
  []

  [to_homogeneous_forward]
    type = MultiAppReporterTransfer
    to_multi_app = homogeneous_forward
    from_reporters = 'OptimizationReporter/source'
    to_reporters = 'gridData/parameter'
  []

  [from_homogeneous_forward]
    type = MultiAppReporterTransfer
    from_multi_app = homogeneous_forward
    from_reporters = 'measured_data/misfit_values
                      measured_data/simulation_values
                      measured_data/measurement_values
                      measured_data/measurement_time'
    to_reporters   = 'OptimizationReporter/misfit_values
                      OptimizationReporter/simulation_values
                      OptimizationReporter/measurement_values
                      OptimizationReporter/measurement_time'
  []

[]

[Outputs]
  # csv=true
[]
