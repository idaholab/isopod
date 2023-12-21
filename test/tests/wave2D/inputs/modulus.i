[Reporters]
  [parameters]
    type = ConstantReporter
    real_vector_names = 'coordx coordy Gr'
    # 'True value when used to generate synthetic data' 
    #real_vector_values = '-7 -7 25 0.25 -0.25; 7 7 80 0.8 -0.8'
    real_vector_values = '-7 7; -7 7; 8 24'
  []
[]

[Functions]
  [Gr_func]
    type = NearestReporterCoordinatesFunction
    x_coord_name = parameters/coordx
    y_coord_name = parameters/coordy
    value_name = parameters/Gr
  []
  [Er_dist]
    type = ParsedFunction
    # expression = 'if((x^2+y^2) < 5^2, 80,25)'
    # expression = '25'
    expression = 3*Gr
    symbol_names = 'Gr'
    symbol_values = 'Gr_func'
  []
  [Ei_dist]
    type = ParsedFunction
    # expression = 'if((x^2+y^2) < 5^2, ${fparse 80*(omega/omega_bar)},${fparse 25*(omega/omega_bar)})'
    # expression = '${fparse 25*omega/omega_bar}'
    expression = Er_dist*${omega}/${omega_bar}
    symbol_names = 'Er_dist'
    symbol_values = 'Er_dist'
  []
  [_Ei_dist]
    type = ParsedFunction
    # expression = 'if((x^2+y^2) < 5^2, ${fparse -80*(omega/omega_bar)},${fparse -25*(omega/omega_bar)})'
    # expression = '${fparse -25*omega/omega_bar}'
    expression = -Ei_dist
    symbol_names = 'Ei_dist'
    symbol_values = 'Ei_dist'
  []
[]
