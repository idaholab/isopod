[Mesh]
  [gmg]
    type = GeneratedMeshGenerator
    dim = 1
    nx = 5
    xmin = 0
    xmax = 2
  []
[]

[Variables]
  [ux]
  []
  [T]
  []
[]

[AuxVariables]
  [state_T]
  []
  [state_x]
  []
  [ux_x]
    order = FIRST
    family = MONOMIAL
  []
  [dummy]
  []
[]

[AuxKernels]
  [ux_x]
    type = VariableGradientComponent
    variable = ux_x
    component = x
    gradient_variable = ux
  []
[]

[DiracKernels]
  [misfit_is_adjoint_force]
    type = ReporterPointSource
    variable = ux
    x_coord_name = misfit/measurement_xcoord
    y_coord_name = misfit/measurement_ycoord
    z_coord_name = misfit/measurement_zcoord
    value_name = misfit/misfit_values
  []
[]

[Kernels]
  [heat_reaction]
    type = Reaction
    variable = T
    rate = 1.0
  []
  [heat_conduction]
    type = MatDiffusion
    variable = T
    diffusivity = 1.0
  []
  [div_sigma_x]
    type = StressDivergenceTensors
    variable = ux
    displacements = 'ux'
    component = 0
    volumetric_locking_correction = false
  []
  [heat_source_x]
    type = MatCoupledForce
    variable = T
    v = ux_x
    material_properties = Bulk3_material
    coef = 0.001  # coeff of thermal expansion
  []
[]

[BCs]
  [left_ux]
    type = DirichletBC
    variable = ux
    boundary = left
    value = 0.0
  []
  [right_T]
    type = NeumannBC
    variable = T
    boundary = right
    value = 0.0
  []
[]

[Materials]
  [alpha_material]
    type = GenericFunctionMaterial
    prop_names = 'alpha_material'
    prop_values = alpha
  []
  [strain]
    type = ComputeSmallStrain
    displacements = 'ux'
  []
  [stress]
    type = ComputeLinearElasticStress
  []
  [elasticity_tensor]
     type = ComputeVariableIsotropicElasticityTensor
     args = dummy
     youngs_modulus = E_material
     poissons_ratio = nu_material
  []
  [E_material]
    type = GenericFunctionMaterial
    prop_names = 'E_material'
    prop_values = E
  []
  [nu_material]
    type = GenericFunctionMaterial
    prop_names = 'nu_material'
    prop_values = nu
  []
  [Bulk3_material]
    type = GenericFunctionMaterial
    prop_names = 'Bulk3_material'
    prop_values = Bulk3
  []
  [forward_strain]
    type = ComputeSmallStrain
    displacements = 'state_x'
    base_name = 'forward'
    eigenstrain_names = thermal_strain
  []
  [thermal_strain]
    type = ComputeThermalExpansionEigenstrain
    temperature = state_T
    thermal_expansion_coeff = '0.001'
    stress_free_temperature = 0.0
    base_name = 'forward'
    eigenstrain_name = thermal_strain
  []
[]

[Functions]
  [Q1]
    type = ParsedOptimizationFunction
    expression = Q1
    param_symbol_names = 'Q1'
    param_vector_name = 'parametrization/Q1'
  []
  [Q]
    type = ParsedOptimizationFunction
    expression = Q
    param_symbol_names = 'Q'
    param_vector_name = 'parametrization/Q'
  []
  [alpha]
    type = NearestReporterCoordinatesFunction
    x_coord_name = parametrization/coordx
    value_name = parametrization/alpha
  []
  [E]
    type = ParsedFunction
    expression = mu*(3*lambda+2*mu)/(lambda+mu)
    symbol_names = 'lambda mu'
    symbol_values = 'lambda mu'
  []
  [nu]
    type = ParsedFunction
    expression = lambda/2/(lambda+mu)
    symbol_names = 'lambda mu'
    symbol_values = 'lambda mu'
  []
  [Bulk3]
    type = ParsedFunction
    expression = (3*lambda+2*mu)
    symbol_names = 'lambda mu'
    symbol_values = 'lambda mu'
  []
  [lambda]
    type = NearestReporterCoordinatesFunction
    x_coord_name = parametrization/coordx
    value_name = parametrization/lambda
  []
  [mu]
    type = NearestReporterCoordinatesFunction
    x_coord_name = parametrization/coordx
    value_name = parametrization/mu
  []
[]

[Reporters]
  [measure_data]
    type = OptimizationData
    variable = ux
  []
  [parametrization]
    type = ConstantReporter
    real_vector_names = 'coordx Q Q1 alpha lambda mu'
    real_vector_values = '0; 5; 2; 0.001; 2; 2'
  []

  [misfit]
    type = OptimizationData
  []
[]

[Executioner]
  type = Steady
  solve_type = NEWTON
  petsc_options_iname = '-pc_type'
  petsc_options_value = 'lu'
[]

[VectorPostprocessors]
  [grad_Q1]
    type = SideOptimizationNeumannFunctionInnerProduct
    variable = T
    function = Q1
    boundary = left
  []
  [grad_Q]
    type = SideOptimizationNeumannFunctionInnerProduct
    variable = T
    function = Q
    boundary = right
  []
  [grad_lambda]
     type = ElementOptimizationLameLambdaInnerProduct
     variable = dummy
     adjoint_strain_name = mechanical_strain
     forward_strain_name = forward_mechanical_strain
     function = lambda
  []
  [grad_mu]
     type = ElementOptimizationLameMuInnerProduct
     variable = dummy
     adjoint_strain_name = mechanical_strain
     forward_strain_name = forward_mechanical_strain
     function = mu
  []
[]

[Outputs]
  file_base = 'forward'
  console = false
[]
