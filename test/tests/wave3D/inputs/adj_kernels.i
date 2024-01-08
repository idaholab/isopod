[DiracKernels]
  [misfit_uxr]
    type = ReporterPointSource
    x_coord_name = measure_data/measurement_xcoord
    y_coord_name = measure_data/measurement_ycoord
    z_coord_name = measure_data/measurement_zcoord
    value_name   = correlation/adjoint_rhs
    weight_name  = measure_data/wxr
    variable     =              uxr_adj
  []
  [misfit_uxi]
    type = ReporterPointSource
    x_coord_name = measure_data/measurement_xcoord
    y_coord_name = measure_data/measurement_ycoord
    z_coord_name = measure_data/measurement_zcoord
    value_name   = correlation/adjoint_rhs
    weight_name  = measure_data/wxi
    variable     =              uxi_adj
  []
  [misfit_uyr]
    type = ReporterPointSource
    x_coord_name = measure_data/measurement_xcoord
    y_coord_name = measure_data/measurement_ycoord
    z_coord_name = measure_data/measurement_zcoord
    value_name   = correlation/adjoint_rhs
    weight_name  = measure_data/wyr
    variable     =              uyr_adj
  []
  [misfit_uyi]
    type = ReporterPointSource
    x_coord_name = measure_data/measurement_xcoord
    y_coord_name = measure_data/measurement_ycoord
    z_coord_name = measure_data/measurement_zcoord
    value_name   = correlation/adjoint_rhs
    weight_name  = measure_data/wyi
    variable     =              uyi_adj
  []
  [misfit_uzr]
    type = ReporterPointSource
    x_coord_name = measure_data/measurement_xcoord
    y_coord_name = measure_data/measurement_ycoord
    z_coord_name = measure_data/measurement_zcoord
    value_name   = correlation/adjoint_rhs
    weight_name  = measure_data/wzr
    variable     =              uzr_adj
  []
  [misfit_uzi]
    type = ReporterPointSource
    x_coord_name = measure_data/measurement_xcoord
    y_coord_name = measure_data/measurement_ycoord
    z_coord_name = measure_data/measurement_zcoord
    value_name   = correlation/adjoint_rhs
    weight_name  = measure_data/wzi
    variable     =              uzi_adj
  []
[]

