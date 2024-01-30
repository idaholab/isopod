# To generate synthetic data
[OptimizationReporter]
  type = GeneralParameterMeshOptimization
  parameter_names  = logGr
  parameter_meshes = inputs/GrMesh.e
  initial_condition_mesh_variable = logGr
  objective_name = objective
[]
[Reporters]
  [GrReporter]
    type = ParsedVectorReporter
    name = Gr
    reporter_names = 'OptimizationReporter/logGr'
    reporter_symbols = 'logGr'
    expression = 'exp(logGr)'
    execution_order_group = -100
    execute_on = TIMESTEP_BEGIN
  []
[]
[Functions]
  [Gr_func]
    type = ParameterMeshFunction
    exodus_mesh = inputs/GrMesh.e
   #parameter_name = parameters/Gr # for inversion
    parameter_name = GrReporter/Gr # for synthetic data
  []
  [Er_dist]
    type = ParsedFunction
    expression    = 2*(1+${nu})*Gr
    symbol_names  = Gr
    symbol_values = Gr_func
  []
  [Ei_dist]
    type = ParsedFunction
    expression    = Er_dist*${ve_factor}
    symbol_names  = Er_dist
    symbol_values = Er_dist
  []
  [_Ei_dist]
    type = ParsedFunction
    expression    = -Ei_dist
    symbol_names  =  Ei_dist
    symbol_values =  Ei_dist
  []
[]
