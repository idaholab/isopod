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
    type = ADStressDivergenceTensors
    variable      = ux
    displacements = 'ux uy'
    component     = 0
    volumetric_locking_correction = true
  []
  [div_sigma_y]
    type = ADStressDivergenceTensors
    variable      = uy
    displacements = 'ux uy'
    component     = 1
    volumetric_locking_correction = true
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
    type = ADComputeLinearElasticStress
  []
  [strain]
    type = ADComputeSmallStrain
    displacements = 'ux uy'
    volumetric_locking_correction = true
  []
  [adjoint_strain]
    type = ADComputeSmallStrain
    displacements = 'ux_adjoint uy_adjoint'
    base_name = 'adjoint'
    volumetric_locking_correction = true
  []
  [elasticity_tensor]
     type = ADComputeVariableIsotropicElasticityTensor
     # args = dummy
     youngs_modulus = E_material
     poissons_ratio = 0.4999
  []
  [E_material]
    type = ADGenericFunctionMaterial
    prop_names = 'E_material'
    prop_values = E
  []

  [reg_mechanical_strain]
    type = RankTwoTensorMaterialADConverter
    ad_props_in = mechanical_strain
    reg_props_out = reg_mechanical_strain
  []
  [reg_adjoint_mechanical_strain]
    type = RankTwoTensorMaterialADConverter
    ad_props_in = adjoint_mechanical_strain
    reg_props_out = reg_adjoint_mechanical_strain
  []
[]

[Functions]
  [E]
    type = ParsedFunction
    expression = 3*mu #2.9998*mu
    symbol_names = 'mu'
    symbol_values = 'mu'
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
  #petsc_options_iname='-pc_type -tao_max_it -tao_fd_test -tao_test_gradient -tao_fd_gradient -tao_fd_delta -tao_gatol'
  #petsc_options_value='lu 1 true true false 1e-8 0.1'
  #petsc_options = '-tao_test_gradient_view'
  nl_forced_its = 1
  line_search = none
  nl_abs_tol = 1e-6
[]

[Outputs]
  console = false
  csv = true
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
  measurement_points = '-1.0 -1.0 0.0
                        -1.0  0.0 0.0
                        -1.0  1.0 0.0
                         0.0 -1.0 0.0
                         0.0  0.0 0.0
                         0.0  1.0 0.0
                         1.0 -1.0 0.0
                         1.0  0.0 0.0
                         1.0  1.0 0.0'
  measurement_values = '4.464620e+00 6.447155e+00 8.434803e+00
                        4.176264e+00 6.172984e+00 8.200859e+00
                        4.049477e+00 6.052499e+00 8.079385e+00'
  []
  [parametrization]
    type = ConstantReporter
    real_vector_names = 'coordx coordy mu'
    real_vector_values = '0 1 2; 0 1 2; 1 2 3'
  []
[]

[VectorPostprocessors]
  [grad_mu]
    type = ElementOptimizationLameMuInnerProduct
    forward_strain_name = 'reg_mechanical_strain'
    adjoint_strain_name = 'reg_adjoint_mechanical_strain'
    variable = dummy
    function = mu
    execute_on = 'ADJOINT_TIMESTEP_END'
  []
[]
