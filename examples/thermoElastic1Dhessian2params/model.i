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
  [dummy]
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
[]

[BCs]
  [left_ux]
    type = DirichletBC
    variable = ux
    boundary = left
    value = 0.0
  []
  [left_T]
    type = FunctionNeumannBC
    variable = T
    boundary = left
    function = Q1
  []
  [right_T]
    type = FunctionNeumannBC
    variable = T
    boundary = right
    function = Q
  []
[]

[Materials]
  [thermal_strain]
    type = ComputeThermalExpansionEigenstrain
    temperature = T
    thermal_expansion_coeff = '0.001'
    stress_free_temperature = 0.0
    eigenstrain_name = thermal_strain
  []
  [alpha_material]
    type = GenericFunctionMaterial
    prop_names = 'alpha_material'
    prop_values = alpha
  []
  [strain]
    type = ComputeSmallStrain
    displacements = 'ux'
    eigenstrain_names = thermal_strain
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
[]

[Executioner]
  type = Steady
  solve_type = NEWTON # dont use linear
  petsc_options_iname = '-pc_type'
  petsc_options_value = 'lu'
[]

[Postprocessors]
  [point0x]
    type = PointValue
    point = '0.0 0.0 0.0'
    variable = ux
    execute_on = TIMESTEP_END
  []
  [point0t]
    type = PointValue
    point = '0.0 0.0 0.0'
    variable = T
    execute_on = TIMESTEP_END
  []
  [point1x]
    type = PointValue
    point = '1.0 0.0 0.0'
    variable = ux
    execute_on = TIMESTEP_END
  []
  [point1t]
    type = PointValue
    point = '1.0 0.0 0.0'
    variable = T
    execute_on = TIMESTEP_END
  []
  [point2x]
    type = PointValue
    point = '2.0 0.0 0.0'
    variable = ux
    execute_on = TIMESTEP_END
  []
  [point2t]
    type = PointValue
    point = '2.0 0.0 0.0'
    variable = T
    execute_on = TIMESTEP_END
  []
[]

[Outputs]
  file_base = 'forward'
  console = true
[]
