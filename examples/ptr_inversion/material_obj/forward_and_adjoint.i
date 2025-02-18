[Mesh]
  [generated]
    type = GeneratedMeshGenerator
    dim = 2
    nx = 25
    ny = 25
    ymin = 0
    xmin = 0
    xmax = 10
    ymax = 10
  []
  # coord_type = RZ
[]

[Problem]
  nl_sys_names = 'nl0 adjoint'
  kernel_coverage_check = FALSE
[]

[Variables]
  [T_real]
    initial_condition = 1e-8
  []
  [T_imag]
    initial_condition = 1e-8
  []
  [T_real_adj]
    initial_condition = 1e-8
    solver_sys = adjoint
  []
  [T_imag_adj]
    initial_condition = 1e-8
    solver_sys = adjoint
  []
[]

[Kernels]
  [heat_conduction_real]
    type = ADMatDiffusion
    variable = T_real
    diffusivity = k
  []
  [02596*]
    type = MatCoupledForce
    variable = T_real
    v = T_imag
    material_properties = 'force_mat'
  []

  [heat_conduction_imag]
    type = ADMatDiffusion
    variable = T_imag
    diffusivity = k
  []
  [heat_source_imag]
    type = MatCoupledForce
    variable = T_imag
    v = T_real
    material_properties = 'force_mat'
    coef = -1
  []
  [adj_source_real]
    type = CoupledForce
    variable = T_real_adj
    v = obj_misfit_Treal_var
  []
  [adj_source_imag]
    type = CoupledForce
    variable = T_imag_adj
    v = obj_misfit_Timag_var
  []
[]

[Materials]
  [k_mat]
    type = ADGenericFunctionMaterial
    prop_names = 'k'
    prop_values = 'kappa_func'
  []
  [mats]
    type = GenericConstantMaterial
    prop_names = 'rho omega cp '
    prop_values = '1.0 1.0 1.0 '
  []
  [force_mat]
    type = ParsedMaterial
    property_name = force_mat
    expression = 'rho * omega * cp'
    material_property_names = 'rho omega cp'
  []
  [phase]
    type = ADParsedMaterial
    coupled_variables = 'T_real T_imag'
    expression = 'atan2(T_imag, T_real)'
    property_name = phase
    # outputs = exodus
  []
  [beam]
    type = ADMaterialReporterOffsetFunctionMaterial
    x_coord_name = measure_data/measurement_xcoord
    y_coord_name = measure_data/measurement_ycoord
    z_coord_name = measure_data/measurement_zcoord
    value_name = measure_data/measurement_values
    sim_material = phase
    function = gauss
    property_name = 'obj_misfit'
    # outputs = exodus
  []
[]

[Functions]
  [gauss]
    type = ParsedFunction
    expression = 'exp(-2.0 *(x^2 + y^2 + z^2)/(beam_radii^2))'
    symbol_names = 'beam_radii'
    symbol_values = '0.1'
  []
  [kappa_func]
    type = ParsedOptimizationFunction
    expression = 'k '
    param_symbol_names = 'k '
    param_vector_name = 'params/k'
  []
[]

[BCs]
  [real_top]
    type = FunctionNeumannBC
    variable = T_real
    boundary = top
    function = 'exp((-2.0 *(x)^2)/0.1)'
  []
[]

[AuxVariables]
  [obj_misfit_Treal_var]
    family = L2_LAGRANGE
  []
  [obj_misfit_Timag_var]
    family = L2_LAGRANGE
  []
  [phase]
  []
  [adj_phase]
  []
[]
[AuxKernels]
  [obj_mis_real]
    # This value needs to be saved for the adjoint system. Material system does
    # not perserve ad info from one nl system to another
    type = ADCoupledVarMaterialDerivativeAux
    variable = obj_misfit_Treal_var
    ad_prop_name = obj_misfit
    coupled_var = T_real
    execute_on = 'TIMESTEP_END'
  []
  [obj_mis_imag]
    type = ADCoupledVarMaterialDerivativeAux
    variable = obj_misfit_Timag_var
    ad_prop_name = obj_misfit
    coupled_var = T_imag
    execute_on = 'TIMESTEP_END'
  []
  [phase]
    type = ParsedAux
    variable = phase
    coupled_variables = 'T_imag T_real'
    expression = 'atan2(T_imag, T_real)'
    execute_on = 'TIMESTEP_END'
  []

  [adj]
    type = ParsedAux
    variable = adj_phase
    coupled_variables = 'T_imag_adj T_real_adj'
    expression = 'atan2(T_imag_adj, T_real_adj)'
    execute_on = 'ADJOINT_TIMESTEP_END'
  []
[]

[Postprocessors]
  [objective]
    type = ADElementIntegralMaterialProperty
    mat_prop = obj_misfit
    execute_on = 'TIMESTEP_END'
  []
[]
[Reporters]
  [measure_data]
    type = OptimizationData
    measurement_values = '-0.663 -2.86'
    measurement_points = '0.55 10 0
                          3.55 10 0'
  []
  [params]
    type = ConstantReporter
    real_vector_names = 'k'
    real_vector_values = '2' # Dummy value
  []
  [gradient]
    type = ParsedVectorReporter
    name = inner
    reporter_names = 'gradient_real/inner_product gradient_imag/inner_product'
    reporter_symbols = 'real imag'
    expression = 'real+imag'
    execute_on = ADJOINT_TIMESTEP_END
  []
[]

[VectorPostprocessors]
  [gradient_real]
    type = ElementOptimizationDiffusionCoefFunctionInnerProduct
    variable = T_real_adj
    forward_variable = T_real
    function = kappa_func
    # boundary = top
    execution_order_group = -1
    execute_on = ADJOINT_TIMESTEP_END
  []
  [gradient_imag]
    type = ElementOptimizationDiffusionCoefFunctionInnerProduct
    variable = T_imag_adj
    forward_variable = T_imag
    function = kappa_func
    # boundary = top
    execution_order_group = -1
    execute_on = ADJOINT_TIMESTEP_END
  []

[]

[Executioner]
  type = SteadyAndAdjoint
  forward_system = nl0
  adjoint_system = adjoint
  nl_rel_tol = 1e-12
  nl_abs_tol = 1e-10
  automatic_scaling = true
  petsc_options_iname = '-pc_type'
  petsc_options_value = 'lu'
  verbose = true
[]

