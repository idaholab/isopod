[Optimization]
[]

[Mesh]
  type = GeneratedMesh
  dim = 2
  nx = 10
  ny = 20
  xmax = 1
  ymax = 2
  bias_x = 1.0
  bias_y = 1.0
[]


[OptimizationReporter]
  type = ObjectiveGradientMinimize
  parameter_names = 'bc_left bc_right'
  num_values = '1 1'
  measurement_points = '0.2 0.2 0
            0.8 0.6 0
            0.2 1.4 0
            0.8 1.8 0'
  measurement_values = '199 214 154 129'
[]

[Executioner]
  type = Optimize
  tao_solver = taolmvm
  petsc_options_iname = '-tao_gatol -tao_max_it' #-tao_ls_type'
  petsc_options_value = '1e-1 50' #unit'
  verbose = true
[]

[MultiApps]
  [forward]
    type = FullSolveMultiApp
    input_files = forward.i
    execute_on = "FORWARD"
    clone_master_mesh = true
  []
  [adjoint]
    type = FullSolveMultiApp
    input_files = adjoint.i
    execute_on = "ADJOINT"
    clone_master_mesh = true
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
                        OptimizationReporter/bc_left
                        OptimizationReporter/bc_right'
      to_reporters = 'measure_data/measurement_xcoord
                      measure_data/measurement_ycoord
                      measure_data/measurement_zcoord
                      measure_data/measurement_time
                      measure_data/measurement_values
                      params_left/vals
                      params_right/vals'
    []
    [fromForward]
      type = MultiAppReporterTransfer
      from_multi_app = forward
      from_reporters = 'measure_data/simulation_values'
      to_reporters = 'OptimizationReporter/simulation_values'
    []
    [toAdjoint]
      type = MultiAppReporterTransfer
      to_multi_app = adjoint
      from_reporters = 'OptimizationReporter/measurement_xcoord
                        OptimizationReporter/measurement_ycoord
                        OptimizationReporter/measurement_zcoord
                        OptimizationReporter/measurement_time
                        OptimizationReporter/misfit_values
                        OptimizationReporter/bc_left
                        OptimizationReporter/bc_right'
      to_reporters = 'misfit/measurement_xcoord
                      misfit/measurement_ycoord
                      misfit/measurement_zcoord
                      misfit/measurement_time
                      misfit/misfit_values
                      params_left/vals
                      params_right/vals'
    []
    [fromadjoint]
      type = MultiAppReporterTransfer
      from_multi_app = adjoint
      from_reporters = 'grad_bc_left/inner_product
                        grad_bc_right/inner_product'
      to_reporters = 'OptimizationReporter/grad_wrt_bc_left
                      OptimizationReporter/grad_wrt_bc_right'
    []
[]

[Reporters]
  [optInfo]
    type = OptimizationInfo
    items = 'gnorm function_value'
  []
[]

[Outputs]
  csv = true
[]
