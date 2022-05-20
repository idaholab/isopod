[StochasticTools]
[]

[Mesh]
  [fmg]
    type = FileMeshGenerator
    file = ./../halfSphere_coarse.e
  []
[]

[OptimizationReporter]
  type = VariableOptimizationReporter
  parameter_variable = p_var
  initial_value = 20
  measurement_points = '4.24  0      2.45
                        4.24  2.45   0
                        4.24  0     -2.45
                        4.24  -2.45  0
                        2.45  0      4.24
                        2.45  4.24   0
                        2.45  0      -4.24
                        2.45  -4.24  0
                        4.9   0      0'
  measurement_values = '296.8965126
                        299.1226708
                        296.9036375
                        294.6646469
                        299.909442
                        305.0568193
                        299.9158336
                        294.7690098
                        295.9769139'
[]

[AuxVariables]
  [p_var]
    order = FIRST
    family = LAGRANGE
  []
[]

[Executioner]
  type = Optimize
  # tao_solver = taonm
  # petsc_options_iname  = ' -tao_gatol -tao_fmin'
  # petsc_options_value = ' 1e-1 1e1'

  tao_solver = taolmvm
  petsc_options_iname = '-tao_fd_gradient -tao_gatol -tao_fmin'
  petsc_options_value = ' true            1e-1 1e1'
  verbose = true
[]

[MultiApps]
  [forward]
    type = OptimizeFullSolveMultiApp
    input_files = forward.i
    execute_on = "FORWARD"
    reset_app = true
  []
  [adjoint]
    type = OptimizeFullSolveMultiApp
    input_files = adjoint.i
    execute_on = "ADJOINT"
  []
[]

[Transfers]
  #these are usually the same for all input files.
    [fromForward]
      type = MultiAppReporterTransfer
      multi_app = forward
      direction = from_multiapp
      from_reporters = 'data_pt/temperature data_pt/temperature'
      to_reporters = 'OptimizationReporter/simulation_values receiver/measured'
    []
    [toAdjoint]
      type = MultiAppReporterTransfer
      multi_app = adjoint
      direction = to_multiapp
      from_reporters = 'OptimizationReporter/measurement_xcoord OptimizationReporter/measurement_ycoord OptimizationReporter/measurement_zcoord OptimizationReporter/misfit_values'
      to_reporters = 'misfit/measurement_xcoord misfit/measurement_ycoord misfit/measurement_zcoord misfit/misfit_values'
    []
    [toForward_measument]
      type = MultiAppReporterTransfer
      multi_app = forward
      direction = to_multiapp
      from_reporters = 'OptimizationReporter/measurement_xcoord OptimizationReporter/measurement_ycoord OptimizationReporter/measurement_zcoord'
      to_reporters = 'measure_data/measurement_xcoord measure_data/measurement_ycoord measure_data/measurement_zcoord'
    []

#these are different,
# - to forward depends on teh parameter being changed
# - from adjoint depends on the gradient being computed from the adjoint
#NOTE:  the adjoint variable we are transferring is actually the gradient
  # [fromadjoint]
  #   type = MultiAppReporterTransfer
  #   multi_app = adjoint
  #   direction = from_multiapp
  #   from_reporters = 'adjoint_bc/adjoint_bc' # what is the naming convention for this
  #   to_reporters = 'OptimizationReporter/adjoint'
  # []
  [to_forward_aux]
    type = MultiAppInterpolationTransfer
    direction = to_multiapp
    multi_app = forward
    source_variable = p_var
    variable = p_var_forward
  []
[]

[Reporters]
  [receiver]
    type = ConstantReporter
    real_vector_names = measured
    real_vector_values = '0'
  []
  [optInfo]
    type = OptimizationInfo
  []
[]

[Outputs]
  csv=true
  # exodus = true
[]
