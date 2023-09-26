# A very simple 1D problem to test multiphysics inversion
# 1D thermoelastic problem where the unknown heat flux
# is inverted with the help of displacement measurements
# This is a single parameter inversion which consititutes
# one of the simplest multiphysics inversion scenarios,
# but it tests to ensure that Hessian inversion converges
# in one iteration

[Optimization]
[]

[OptimizationReporter]
  type = OptimizationReporter
  parameter_names = 'Q'
  num_values = '1'
  initial_condition = '0.2'
  lower_bounds = '0.1'
  upper_bounds = '100'
  measurement_points = '0.0 0.0 0.0
                        1.0 0.0 0.0
                        2.0 0.0 0.0'
  measurement_values = '0.000000 4.333333333e-03 16.666666667e-03'
[]

[Executioner]
  type = Optimize
  tao_solver = taonls
  petsc_options_iname = '-tao_gatol -tao_nls_pc_type -tao_nls_ksp_type'
  petsc_options_value = '1e-9 none cg'
  verbose = true

#  THESE OPTIONS ARE FOR TESTING THE ADJOINT GRADIENT
#  petsc_options_iname='-tao_max_it -tao_fd_test -tao_test_gradient -tao_fd_gradient -tao_fd_delta -tao_gatol'
#  petsc_options_value='1 true true false 1e-8 0.1'
#  petsc_options = '-tao_test_gradient_view'
[]

[MultiApps]
  [forward]
    type = FullSolveMultiApp
    input_files = model.i
    execute_on = FORWARD
  []
  [adjoint]
    type = FullSolveMultiApp
    input_files = grad.i
    execute_on = ADJOINT
  []
  [homoForward]
    type = FullSolveMultiApp
    input_files = homoForward.i
    execute_on = HOMOGENEOUS_FORWARD
  []
[]

[Transfers]
  [toForward]
    type = MultiAppReporterTransfer
    to_multi_app = forward
    from_reporters = 'OptimizationReporter/measurement_xcoord
                      OptimizationReporter/measurement_ycoord
                      OptimizationReporter/measurement_zcoord
                      OptimizationReporter/measurement_time
                      OptimizationReporter/measurement_values
                      OptimizationReporter/Q'
    to_reporters = 'measure_data/measurement_xcoord
                    measure_data/measurement_ycoord
                    measure_data/measurement_zcoord
                    measure_data/measurement_time
                    measure_data/measurement_values
                    parametrization/Q'
  []
  [get_misfit]
    type = MultiAppReporterTransfer
    from_multi_app = forward
    from_reporters = 'measure_data/simulation_values'
    to_reporters = 'OptimizationReporter/simulation_values'
  []
  [set_state_for_adjoint]
    type = MultiAppCopyTransfer
    from_multi_app = forward
    to_multi_app = adjoint
    source_variable = 'ux T'
    variable = 'state_x state_T'
  []
  [setup_adjoint_run]
    type = MultiAppReporterTransfer
    to_multi_app = adjoint
    from_reporters = 'OptimizationReporter/measurement_xcoord
                      OptimizationReporter/measurement_ycoord
                      OptimizationReporter/measurement_zcoord
                      OptimizationReporter/measurement_time
                      OptimizationReporter/misfit_values
                      OptimizationReporter/Q'
    to_reporters = 'misfit/measurement_xcoord
                    misfit/measurement_ycoord
                    misfit/measurement_zcoord
                    misfit/measurement_time
                    misfit/misfit_values
                    parametrization/Q'
  []
  [get_grad_Q]
    type = MultiAppReporterTransfer
    from_multi_app = adjoint
    from_reporters = 'grad_Q/inner_product'
    to_reporters = 'OptimizationReporter/grad_Q'
  []
## Hessian transfers
  [toHomoForward]
    type = MultiAppReporterTransfer
    to_multi_app = homoForward
    from_reporters = 'OptimizationReporter/measurement_xcoord
                      OptimizationReporter/measurement_ycoord
                      OptimizationReporter/measurement_zcoord
                      OptimizationReporter/measurement_time
                      OptimizationReporter/measurement_values
                      OptimizationReporter/Q'
    to_reporters = 'measure_data/measurement_xcoord
                    measure_data/measurement_ycoord
                    measure_data/measurement_zcoord
                    measure_data/measurement_time
                    measure_data/measurement_values
                    parametrization/Q'
  []
  [get_misfit_from_homoForward]
    type = MultiAppReporterTransfer
    from_multi_app = homoForward
    from_reporters = 'measure_data/simulation_values'
    to_reporters = 'OptimizationReporter/simulation_values'
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
