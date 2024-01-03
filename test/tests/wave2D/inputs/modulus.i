[Reporters]
  [parameters]
    type = ConstantReporter
#    real_vector_names = 'coordx coordy Gr'
#    real_vector_values = '-7 7 0; -7 7 0; 4 4 ${fparse Gr}'
    real_vector_names = 'Gr'
    real_vector_values = '${Gr} ${Gr} ${Gr} ${Gr} ${Gr} ${Gr} ${Gr} ${Gr} ${Gr} ${Gr} ${Gr} ${Gr} ${Gr} ${Gr} ${Gr} ${Gr}' # 16 entries for 3x3 mesh
#    real_vector_values = '${Gr} ${Gr} ${Gr} ${Gr} ${Gr} ${Gr} ${Gr} ${Gr} ${Gr}' # 9 entries for 2x2 mesh
  []
[]

[Functions]
  [Gr_func]
#    type = NearestReporterCoordinatesFunction
#    x_coord_name = parameters/coordx
#    y_coord_name = parameters/coordy
#    value_name   = parameters/Gr
    type = ParameterMeshFunction
    exodus_mesh = GrMesh.e
    parameter_name = parameters/Gr
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
