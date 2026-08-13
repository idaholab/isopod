[Optimization]
[]

[OptimizationReporter]
  type = GeneralOptimization
  objective_name = objective_value
  parameter_names = 'parameter_results'
  num_values = '3'
[]

[Reporters]
  [main]
    type = OptimizationData
    measurement_points = '0.0 0.3 0
                          0.0 0.5 0
                          0.0 1.0 0'
    measurement_values = '100 200 300'
  []
  [receiver]
    type = ConstantReporter
    real_vector_names = measured
    real_vector_values = '0 0 0'
  []
[]

[Executioner]
  type = Optimize
  tao_solver = taolmvm
  petsc_options_iname = '-tao_gatol -tao_ls_type'
  petsc_options_value = '1e-4 unit'
  verbose = true
[]

[MultiApps]
  [forward]
    type = FullSolveMultiApp
    input_files = forward.i
    execute_on = "FORWARD"
  []
  [adjoint]
    type = FullSolveMultiApp
    input_files = adjoint.i
    execute_on = "ADJOINT"
  []
[]

[Transfers]
  [toForward]
    type = MultiAppReporterTransfer
    to_multi_app = forward
    from_reporters = 'main/measurement_xcoord
                      main/measurement_ycoord
                      main/measurement_zcoord
                      main/measurement_time
                      main/measurement_values
                      OptimizationReporter/parameter_results'
    to_reporters = 'measure_data/measurement_xcoord
                    measure_data/measurement_ycoord
                    measure_data/measurement_zcoord
                    measure_data/measurement_time
                    measure_data/measurement_values
                    point_source/value'
  []
  [fromForward]
    type = MultiAppReporterTransfer
    from_multi_app = forward
    # objective_value feeds GeneralOptimization; simulation_values feed the
    # receiver output; misfit_values are held on the main app for the adjoint
    from_reporters = 'measure_data/objective_value
                      measure_data/simulation_values
                      measure_data/misfit_values'
    to_reporters = 'OptimizationReporter/objective_value
                    receiver/measured
                    main/misfit_values'
  []
  [toAdjoint]
    type = MultiAppReporterTransfer
    to_multi_app = adjoint
    from_reporters = 'main/measurement_xcoord
                      main/measurement_ycoord
                      main/measurement_zcoord
                      main/measurement_time
                      main/misfit_values'
    to_reporters = 'misfit/measurement_xcoord
                    misfit/measurement_ycoord
                    misfit/measurement_zcoord
                    misfit/measurement_time
                    misfit/misfit_values'
  []
  [fromadjoint]
    type = MultiAppReporterTransfer
    from_multi_app = adjoint
    from_reporters = 'gradient/adjointVar'
    to_reporters = 'OptimizationReporter/grad_parameter_results'
  []
[]

[Outputs]
  console = true
  csv=true
[]
