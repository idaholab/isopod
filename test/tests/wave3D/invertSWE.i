[Optimization]
[]

[OptimizationReporter]
  type = GeneralParameterMeshOptimization
  parameter_names  = logGr
  parameter_meshes = inputs/GrMesh.e
  initial_condition_mesh_variable = logGr
  constant_group_lower_bounds = -2
  constant_group_upper_bounds = 2
  objective_name = objective
[]
[Executioner]
  type = Optimize
  tao_solver = taobqnls
  petsc_options_iname = '-tao_gatol -tao_max_it -tao_ls_type'
  petsc_options_value = '1e-6 ${maxiter} unit'
  verbose = true
[]
[Reporters]
  [OptimizationInfo]
    type = OptimizationInfo
    items = 'current_iterate function_value gnorm'
  []
[]

[MultiApps]
  [model_grad_sampler]
    type = FullSolveMultiApp
    input_files = 'samplerSWE.i'
    execute_on = FORWARD
  []
[]
[Transfers]
  [SetParameters]
    type = MultiAppReporterTransfer
    to_multi_app = model_grad_sampler
    from_reporters = 'OptimizationReporter/logGr'
    to_reporters = 'parameters/logGr'
  []
  [GetObjectiveGradient]
    type = MultiAppReporterTransfer
    from_multi_app = model_grad_sampler
    from_reporters = 'objective/objective
                      gradient/gradient'
    to_reporters = 'OptimizationReporter/objective
                    OptimizationReporter/grad_logGr'
  []
[]

[Mesh]
  [ParameterMesh]
    type = FileMeshGenerator
    file = inputs/GrMesh.e
  []
[]
[AuxVariables]
  [logGr]
    family = LAGRANGE
    order  = FIRST
  []
[]
[AuxKernels]
  [GrOut]
    type = FunctionAux
    variable = logGr
    function = logGrFunc
    execute_on = TIMESTEP_END
  []
[]
[Functions]
  [logGrFunc]
    type = ParameterMeshFunction
    family = LAGRANGE
    order  = FIRST
    exodus_mesh = inputs/GrMesh.e
    parameter_name = OptimizationReporter/logGr
    execute_on = TIMESTEP_END
  []
[]

[Outputs]
  csv = true
  console = false
  exodus = yes
  file_base = inversion/GrMesh
  execute_on = TIMESTEP_END
[]
