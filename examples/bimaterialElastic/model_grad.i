[Problem]
  nl_sys_names = 'nl0 adjoint'
  kernel_coverage_check = false
[]

[Mesh]
  [gmg]
    type = GeneratedMeshGenerator
    dim  =  2
    nx   = 11
    ny   = 11
    xmin = -4
    xmax =  4
    ymin = -4
    ymax =  4
  []
[]

[Variables]
  [ux]
  []
  [uy]
  []
  [ux_adjoint]
    nl_sys = adjoint
  []
  [uy_adjoint]
    nl_sys = adjoint
  []
[]

[AuxVariables]
  [dummy]
  []
[]

[Kernels]
  [div_sigma_x]
    type = StressDivergenceTensors
    variable      = ux
    displacements = 'ux uy'
    component     = 0
    volumetric_locking_correction = false
  []
  [div_sigma_y]
    type = StressDivergenceTensors
    variable      = uy
    displacements = 'ux uy'
    component     = 1
    volumetric_locking_correction = false
  []
[]

[BCs]
  [bottom_ux]
    type = DirichletBC
    variable = ux
    boundary = bottom
    value = 0.0
  []
  [bottom_uy]
    type = DirichletBC
    variable = uy
    boundary = bottom
    value = 0.0
  []
  [top_fx]
    type = NeumannBC
    variable = ux
    boundary = top
    value = 1.0
  []
  [top_fy]
    type = NeumannBC
    variable = uy
    boundary = top
    value = 1.0
  []
[]

[Materials]
  [stress]
    type = ComputeLinearElasticStress
  []
  [strain]
    type = ComputeSmallStrain
    displacements = 'ux uy'
  []
  [adjoint_strain]
    type = ComputeSmallStrain
    displacements = 'ux_adjoint uy_adjoint'
    base_name = 'adjoint'
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
    y_coord_name = parametrization/coordy
    value_name = parametrization/lambda
  []
  [mu]
    type = NearestReporterCoordinatesFunction
    x_coord_name = parametrization/coordx
    y_coord_name = parametrization/coordy
    value_name = parametrization/mu
  []
[]

[Executioner]
  type = SteadyAndAdjoint
  forward_system = nl0
  adjoint_system = adjoint
  petsc_options_iname='-pc_type'
  petsc_options_value='lu'
  nl_forced_its = 1
  line_search = none
  nl_abs_tol = 1e-8
[]

[Outputs]
  console = false
  csv = false
[]

[DiracKernels]
  [misfit_is_adjoint_force]
    type = ReporterPointSource
    variable = ux_adjoint
    x_coord_name = measure_data/measurement_xcoord
    y_coord_name = measure_data/measurement_ycoord
    z_coord_name = measure_data/measurement_zcoord
    value_name = measure_data/misfit_values
  []
[]

[Reporters]
  [measure_data]
    type = OptimizationData
    variable = ux
  []
  [parametrization]
    type = ConstantReporter
    real_vector_names = 'coordx coordy lambda mu'
    real_vector_values = '0 1 2; 0 1 2; 5 4 3; 1 2 3'
  []
[]

[VectorPostprocessors]
  [grad_lambda]
    type = ElementOptimizationLameLambdaInnerProduct
    forward_strain_name = 'mechanical_strain'
    adjoint_strain_name = 'adjoint_mechanical_strain'
    #adjoint_strain_name = 'adjoint_total_strain'
    variable = dummy
    function = lambda
    execute_on = 'ADJOINT_TIMESTEP_END'
  []
  [grad_mu]
    type = ElementOptimizationLameMuInnerProduct
    forward_strain_name = 'mechanical_strain'
    adjoint_strain_name = 'adjoint_mechanical_strain'
    #adjoint_strain_name = 'adjoint_total_strain'
    variable = dummy
    function = mu
    execute_on = 'ADJOINT_TIMESTEP_END'
  []
[]
