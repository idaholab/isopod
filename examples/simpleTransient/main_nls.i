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
  [homogeneous_forward]
    type = OptimizeFullSolveMultiApp
    input_files = homogeneous_forward.i
    execute_on = HOMOGENEOUS_FORWARD
  []
[]

[Transfers]
  [to_forward]
    type = MultiAppReporterTransfer
    to_multi_app = forward
    from_reporters = 'OptimizationReporter/source'
    to_reporters   = 'src_values/values'
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
    to_multi_app   = adjoint
    from_reporters = 'OptimizationReporter/source
                      OptimizationReporter/misfit_values'
    to_reporters   = 'src_values/values
                      measured_data/misfit_values'
  []
  [from_adjoint]
    type = MultiAppReporterTransfer
    from_multi_app = adjoint
    from_reporters = 'adjoint/inner_product'
    to_reporters   = 'OptimizationReporter/adjoint'
  []
  [to_homogeneous_forward]
    type = MultiAppReporterTransfer
    to_multi_app = homogeneous_forward
    from_reporters = 'OptimizationReporter/source'
    to_reporters = 'src_values/values'
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

[Executioner]
  type = Optimize
  solve_on = none
  tao_solver = taonls
  petsc_options_iname='-tao_gatol -tao_nls_pc_type -tao_nls_ksp_type'
  petsc_options_value='2e-4 none cg'
  #tao_solver = lmvm
  #petsc_options_iname='-tao_gatol -tao_ls_type'
  #petsc_options_value='1e-3 unit'
  #petsc_options_iname='-tao_gatol -tao_ls_type -tao_test_gradient'
  #petsc_options_value='1e-3 unit true'
  verbose = true
[]

[Outputs]
  [out]
    execute_system_information_on=none
    type = JSON
  []
[]
