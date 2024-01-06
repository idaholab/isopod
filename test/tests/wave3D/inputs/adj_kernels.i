[DiracKernels]
  [misfit_uxr]
    type = ReporterPointSource
    x_coord_name = measure_data/measurement_xcoord
    y_coord_name = measure_data/measurement_ycoord
    z_coord_name = measure_data/measurement_zcoord
    value_name   = correlation/adjoint_rhs
    weight_name  = measure_data/weight_uxr
    variable     =                     uxr_adj
  []
  [misfit_uxi]
    type = ReporterPointSource
    x_coord_name = measure_data/measurement_xcoord
    y_coord_name = measure_data/measurement_ycoord
    z_coord_name = measure_data/measurement_zcoord
    value_name   = correlation/adjoint_rhs
    weight_name  = measure_data/weight_uxi
    variable     =                     uxi_adj
  []
  [misfit_uyr]
    type = ReporterPointSource
    x_coord_name = measure_data/measurement_xcoord
    y_coord_name = measure_data/measurement_ycoord
    z_coord_name = measure_data/measurement_zcoord
    value_name   = correlation/adjoint_rhs
    weight_name  = measure_data/weight_uyr
    variable     =                     uyr_adj
  []
  [misfit_uyi]
    type = ReporterPointSource
    x_coord_name = measure_data/measurement_xcoord
    y_coord_name = measure_data/measurement_ycoord
    z_coord_name = measure_data/measurement_zcoord
    value_name   = correlation/adjoint_rhs
    weight_name  = measure_data/weight_uyi
    variable     =                     uyi_adj
  []
  [misfit_uzr]
    type = ReporterPointSource
    x_coord_name = measure_data/measurement_xcoord
    y_coord_name = measure_data/measurement_ycoord
    z_coord_name = measure_data/measurement_zcoord
    value_name   = correlation/adjoint_rhs
    weight_name  = measure_data/weight_uzr
    variable     =                     uzr_adj
  []
  [misfit_uzi]
    type = ReporterPointSource
    x_coord_name = measure_data/measurement_xcoord
    y_coord_name = measure_data/measurement_ycoord
    z_coord_name = measure_data/measurement_zcoord
    value_name   = correlation/adjoint_rhs
    weight_name  = measure_data/weight_uzi
    variable     =                     uzi_adj
  []
[]

[Reporters]
  [measure_data]
    type = OptimizationData
    variable              = '       uxr        uxi        uyr        uyi        uzr        uzi'
    variable_weight_names = 'weight_uxr weight_uxi weight_uyr weight_uyi weight_uzr weight_uzi'
    file_variable_weights = 'weight_uxr weight_uxi weight_uyr weight_uyi weight_uzr weight_uzi'
    file_value            = 'value'
    measurement_file = 'measurement/frequency${id}.csv'
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
