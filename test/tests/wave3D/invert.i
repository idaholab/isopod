[Optimization]
[]

[OptimizationReporter]
  type = GeneralParameterMeshOptimization
  parameter_names  = Gr
  parameter_meshes = inputs/GrMesh.e
  initial_condition_mesh_variable = Gr
  constant_group_lower_bounds = 0.1 # Be careful that these bounds are consistent with initial estimates
  constant_group_upper_bounds = 3.0 # Be careful that these bounds are consistent with initial estimates
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
    input_files = 'sampler.i'
    execute_on = FORWARD
  []
[]
[Transfers]
  [SetParameters]
    type = MultiAppReporterTransfer
    to_multi_app = model_grad_sampler
    from_reporters = 'OptimizationReporter/Gr'
    to_reporters = 'parameters/Gr'
  []
  [GetObjectiveGradient]
    type = MultiAppReporterTransfer
    from_multi_app = model_grad_sampler
    from_reporters = 'objective/objective
                      gradient/gradient'
    to_reporters = 'OptimizationReporter/objective
                    OptimizationReporter/grad_Gr'
  []
[]

[Mesh]
  [ParameterMesh]
    type = FileMeshGenerator
    file = inputs/GrMesh.e
  []
[]
[AuxVariables]
  [Gr]
    family = LAGRANGE
    order  = FIRST
  []
[]
[AuxKernels]
  [GrOut]
    type = FunctionAux
    variable = Gr
    function = GrFunc
    execute_on = TIMESTEP_END
  []
[]
[Functions]
  [GrFunc]
    type = ParameterMeshFunction
    family = LAGRANGE
    order  = FIRST
    exodus_mesh = inputs/GrMesh.e
    parameter_name = OptimizationReporter/Gr
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
