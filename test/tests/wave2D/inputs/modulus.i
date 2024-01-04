# To generate synthetic data
#[OptimizationReporter]
#  type = GeneralParameterMeshOptimization
#  parameter_names  = Gr
#  parameter_meshes = inputs/GrMesh.e
#  initial_condition_mesh_variable = Gr
#  objective_name = objective
#[]

# For inversion
[Reporters]
  [parameters]
    type = ConstantReporter
    real_vector_names = 'Gr'
    real_vector_values = '${Gr} ${Gr} ${Gr} ${Gr} ${Gr} ${Gr} ${Gr} ${Gr} ${Gr} ${Gr} ${Gr} ${Gr} ${Gr} ${Gr} ${Gr} ${Gr}' # 16 entries for 3x3 mesh
  []
[]

[Functions]
  [Gr_func]
    type = ParameterMeshFunction
    exodus_mesh = inputs/GrMesh.e
    parameter_name = parameters/Gr # for inversion
   #parameter_name = OptimizationReporter/Gr # for synthetic data
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
