[Reporters]
  [measure_data]
    type = OptimizationData
    variable              = 'uxr uxi uyr uyi uzr uzi'
    variable_weight_names = 'wxr wxi wyr wyi wzr wzi'
    file_variable_weights = 'wxr wxi wyr wyi wzr wzi'
    file_value            = 'value'
    measurement_file = 'SWEmeas/SWE${push_id}freq${frequencyDeciHz}.csv'
  []
  [correlation]
    #type = L2ObjectiveAndGradient
    type = CorrelationObjectiveAndGradient
    measurement_vector = measure_data/measurement_values
    simulation_vector = measure_data/simulation_values
    objective_name = objective
    adjoint_rhs_vector_name = adjoint_rhs
  []
[]
