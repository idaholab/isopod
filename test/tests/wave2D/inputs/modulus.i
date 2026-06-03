# For inversion
[Reporters]
  [parameters]
    type = ConstantReporter
    real_vector_names = 'Gr'
    real_vector_values = '4.0' # dummy
  []
[]

[Functions]
  [Gr_func]
    type = ParameterMeshFunction
    exodus_mesh = /Users/mundlb/projects/isopod/test/tests/wave2D/inputs/GrMesh.e
    parameter_name = parameters/Gr # for inversion
    #parameter_name = OptimizationReporter/Gr # for synthetic data
  []
  [Er_dist]
    type = ParsedFunction
    expression = 2*(1+${nu})*Gr
    symbol_names = Gr
    symbol_values = Gr_func
  []
  [Ei_dist]
    type = ParsedFunction
    expression = Er_dist*${ve_factor}
    symbol_names = Er_dist
    symbol_values = Er_dist
  []
  [_Ei_dist]
    type = ParsedFunction
    expression = -Ei_dist
    symbol_names = Ei_dist
    symbol_values = Ei_dist
  []
[]
