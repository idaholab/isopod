id = 1
frequencyHz = 1.0
omega = '${fparse 2*3.14159265359*frequencyHz}'

[Problem]
  nl_sys_names = 'nl0 adjoint'
  kernel_coverage_check = false
[]
[Executioner]
  type = SteadyAndAdjoint
  forward_system = nl0
  adjoint_system = adjoint
  #petsc_options_iname = '-pc_type'
  #petsc_options_value = 'lu'
  petsc_options_iname = '-pc_type -tao_fd_test -tao_test_gradient -tao_fd_gradient'
  petsc_options_value = 'lu true true false'
  petsc_options = '-tao_test_gradient_view'
  nl_forced_its = 1
  line_search = none
  nl_abs_tol = 1e-8
[]
[Outputs]
  csv = fasle
  console = false
  json = true
  #file_base = model_grad/${id}
[]

[Mesh]
  type = GeneratedMesh
  dim = 1
  nx = 200
  xmax = 20
[]

[Variables]
  [ur]
  []
  [ui]
  []
  [uradj]
    nl_sys = adjoint
  []
  [uiadj]
    nl_sys = adjoint
  []
[]

[Kernels]
  [stiff]
    type = MatDiffusion
    variable = ur
    diffusivity = G
  []
  [mass]
    type = Reaction
    variable = ur
    rate = ${fparse -omega*omega}
  []
  [stiffV]
    type = MatDiffusion
    variable = ui
    diffusivity =G
  []
  [massV]
    type = Reaction
    variable = ui
    rate = ${fparse -omega*omega}
  []
[]

[BCs]
  [leftU]
    type = CoupledVarNeumannBC
    variable = ur
    boundary = left
    coef = 1.0
    v = ui
  []
  [leftV]
    type = CoupledVarNeumannBC
    variable = ui
    boundary = left
    coef = -1.0
    v = ur
  []
  [right]
    type = NeumannBC
    variable = ur
    boundary = right
    value = 1
  []
[]

[Materials]
  [G]
    type = GenericFunctionMaterial
    prop_names = G
    prop_values = G_function
  []
[]

[Functions]
  [G_function]
    type = NearestReporterCoordinatesFunction
    x_coord_name = parameters/coordx
    value_name = parameters/G
  []
[]

[Reporters]
  [parameters]
    type = ConstantReporter
    real_vector_names = 'coordx G'
    # 'True value when used to generate synthetic data' 
    real_vector_values = '5.0 15.0; 4.0 4.0'
  []
[]

[DiracKernels]
  [misfit_ur]
    type = ReporterPointSource
    variable = uradj
    # drop_duplicate_points = false
    x_coord_name = measure_data/measurement_xcoord
    y_coord_name = measure_data/measurement_ycoord
    z_coord_name = measure_data/measurement_zcoord
    weight_name  = measure_data/weight_ur
    value_name   = correlation/adjoint_rhs
  []
  [misfit_ui]
    type = ReporterPointSource
    variable = uiadj
    # drop_duplicate_points = false
    x_coord_name = measure_data/measurement_xcoord
    y_coord_name = measure_data/measurement_ycoord
    z_coord_name = measure_data/measurement_zcoord
    weight_name  = measure_data/weight_ui
    value_name   = correlation/adjoint_rhs
  []
[]

[VectorPostprocessors]
  [gradient_from_real]
    type = ElementOptimizationDiffusionCoefFunctionInnerProduct
    variable = uradj
    forward_variable = ur
    function = G_function
    execute_on = ADJOINT_TIMESTEP_END
    execution_order_group = -1
  []
  [gradient_from_imag]
    type = ElementOptimizationDiffusionCoefFunctionInnerProduct
    variable = uiadj
    forward_variable = ui
    function = G_function
    execute_on = ADJOINT_TIMESTEP_END
    execution_order_group = -1
  []
  [gradient]
    type = VectorPostprocessorSum
    vectorpostprocessor_a = gradient_from_real
    vector_name_a = inner_product
    vectorpostprocessor_b = gradient_from_imag
    vector_name_b = inner_product
    execute_on = ADJOINT_TIMESTEP_END
    execution_order_group = 0
  []
[]

[Reporters]
  [measure_data]
    type = OptimizationData
    variable = 'ur ui'
    variable_weight_names = 'weight_ur weight_ui'
    file_variable_weights = 'weight_ur weight_ui'
    file_value = 'value'
    measurement_file = 'measurement/frequency${id}.csv'
  []
  [correlation]
    type = L2ObjectiveAndGradient
    #type = CorrelationObjectiveAndGradient
    measurement_vector = measure_data/measurement_values
    simulation_vector = measure_data/simulation_values
    objective_name = 'objective'
    adjoint_rhs_vector_name = 'adjoint_rhs'
  []
[]
