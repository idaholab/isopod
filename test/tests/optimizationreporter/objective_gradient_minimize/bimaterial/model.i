# Heat conduction in a 2D domain with two diffusivities
# The domain is -5 <= x <= 5 and -5 <= y <= 5
# The top-half of the domain (y > 0) has high diffusivity
# The top-half of the domain (y < 0) has low diffusivity
# Temperature is initialised to zero
# Temperature is fixed at temperature = 1 at centre of the domain (which is on the interface between the top and bottom halves)
#
# Assume experimental observations of the temperature are made at time = 1, and yield:
# at point = (-2, -2, 0), temperature = 0.022
# at point = (0, -2, 0), temperature = 0.040
# at point = (2, -2, 0), temperature = 0.022
# at point = (0, 2, 0), temperature = 0.138
# Notice that the temperature is higherin the top (y > 0) half of the domain because the diffusivity is higher there
#
# This MOOSE model will give different predictions for temperature, depending on the time-step size and the spatial resolution
# For dt = 1, nx = 100, ny = 100, the experimental observations are well-matched for
# diffusivity of top ~ 10
# diffusivity of bottom ~ 1
#
# The purpose of the main.i input file is to find this solution
#
# The unusual things about this input file are:
# - the diffusivity values are not just stored in two Materials.  Instead, the Materials get their values from Functions (they are GenericFunctionMaterials) which get their values from Postprocessors, which get their values from a VectorPostprocessor.  The reason for this rather convoluted approach is because the VectorPostprocessor can be controlled by a MultiAppReporterTransfer in main.i
# - the existance of the MeasuredDataPointSampler VectorPostprocessor: it simply records the difference between the MOOSE prediction and the experimental observations
#
[Mesh]
  [gmg]
    type = GeneratedMeshGenerator
    dim = 2
    nx = 16 # keep this even to ensure there is a central node
    ny = 16 # keep this even to ensure there is a central node
    xmin = -4
    xmax = 4
    ymin = -4
    ymax = 4
  []
  [bimaterial]
    type = SubdomainBoundingBoxGenerator
    input = gmg
    block_id = 1
    bottom_left = '-100 -100 -100'
    top_right = '100 0 100'
  []
  [name_blocks]
    type = RenameBlockGenerator
    input = bimaterial
    old_block = '0 1'
    new_block = 'top bottom'
  []
  [central_node]
    type = ExtraNodesetGenerator
    input = name_blocks
    coord = '0 0 0'
    new_boundary = central_node
  []
[]

[Variables]
  [temperature]
  []
[]

[Kernels]
  [conduction]
    type = MatDiffusion
    diffusivity = diffusivity
    variable = temperature
  []
  [heat_source]
    type = ADMatHeatSource
    material_property = volumetric_heat
    variable = temperature
  []
[]
[AuxVariables]
  [grad_Tx]
    order = CONSTANT
    family = MONOMIAL
  []
  [grad_Ty]
    order = CONSTANT
    family = MONOMIAL
  []
  [grad_Tz]
    order = CONSTANT
    family = MONOMIAL
  []
[]
[AuxKernels]
  [grad_Tx]
    type = VariableGradientComponent
    component = x
    variable = grad_Tx
    gradient_variable = temperature
  []
  [grad_Ty]
    type = VariableGradientComponent
    component = y
    variable = grad_Ty
    gradient_variable = temperature
  []
  [grad_Tz]
    type = VariableGradientComponent
    component = z
    variable = grad_Tz
    gradient_variable = temperature
  []
[]
[BCs]

  [bottom]
    type = DirichletBC
    variable = temperature
    boundary = bottom
    value = 0
  []
  # [top]
  #   type = DirichletBC
  #   variable = temperature
  #   boundary = top
  #   value = 100
  # []
[]

[Functions]
  [diffusivity_top_function]
    type = ParsedFunction
    value = alpha
    vars = alpha
    vals = d_top
  []
  [diffusivity_bottom_function]
    type = ParsedFunction
    value = alpha
    vars = alpha
    vals = d_bot
  []
[]

[Materials]
  [mat_top]
    type = GenericFunctionMaterial
    block = 'top'
    prop_names = diffusivity
    prop_values = diffusivity_top_function
  []
  [mat_bottom]
    type = GenericFunctionMaterial
    block = 'bottom'
    prop_names = diffusivity
    prop_values = diffusivity_bottom_function
  []
  [volumetric_heat]
    type = ADGenericFunctionMaterial
    prop_names = 'volumetric_heat'
    prop_values = 100
  []
[]

[Postprocessors]
  [d_bot]
    type = VectorPostprocessorComponent
    index = 0
    vectorpostprocessor = vector_pp
    vector_name = diffusivity_values
    execute_on = 'initial linear'
  []
  [d_top]
    type = VectorPostprocessorComponent
    index = 1
    vectorpostprocessor = vector_pp
    vector_name = diffusivity_values
    execute_on = 'initial linear'
  []
[]

[VectorPostprocessors]
  [vector_pp]
    type = ConstantVectorPostprocessor
    vector_names = diffusivity_values
    value = '5 10' #we need to set initial values (any values)- these will be over-written
  []
  [data_pt]
    type = VppPointValueSampler
    variable = temperature
    reporter_name = measure_data
  []
  # [syntheticData]
  #   type = NodalValueSampler
  #   sort_by = id
  #   variable = 'temperature'
  #   block = 'top'
  # []
[]


[Reporters]
  [measure_data]
    type=OptimizationData
  []
[]

[Executioner]
  type = Steady
  solve_type = NEWTON
  petsc_options_iname = '-pc_type'
  petsc_options_value = 'lu'
  nl_forced_iters = 1
  line_search=none
  nl_abs_tol=1e-8
[]

[Outputs]
  console = true
  print_linear_residuals = false
  exodus = false
  csv=true

[]



