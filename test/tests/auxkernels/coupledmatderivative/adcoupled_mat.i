[Mesh]
  [generated]
    type = GeneratedMeshGenerator
    dim = 2
    nx = 5
    ny = 5
  []
[]

[Variables]
  [u]
  []
[]

[AuxVariables]
  [dmat_du]
    family = MONOMIAL
    order = CONSTANT
  []
[]

[Kernels]
  [diff]
    type = Diffusion
    variable = u
  []
[]

[BCs]
  [left]
    type = DirichletBC
    variable = u
    value = 0
    boundary = left
  []
  [right]
    type = DirichletBC
    variable = u
    value = 1
    boundary = right
  []
[]

[AuxKernels]
  [deriv_aux]
    type = ADCoupledVarMaterialDerivativeAux
    variable = dmat_du
    ad_prop_name = parsed_mat
    coupled_var = u
  []
[]

[Materials]
  [parsed_mat]
    type = ADParsedMaterial
    coupled_variables = 'u'
    property_name = parsed_mat
    extra_symbols = 'x'
    expression = 'u*u + u*x'
  []
  [parsed_mat_deriv_exact]
    type = ADParsedMaterial
    coupled_variables = 'u'
    property_name = parsed_mat_deriv_exact
    expression = '2*u + x'
    extra_symbols = 'x'
    output_properties = parsed_mat_deriv_exact
    outputs = exodus
  []
[]

[Executioner]
  type = Steady
[]

[Postprocessors]
  [difference]
    type = ElementL2Difference
    variable = dmat_du
    other_variable = parsed_mat_deriv_exact
    execute_on = TIMESTEP_END
  []
[]

[Outputs]
  exodus = true
  execute_on = 'TIMESTEP_END'
[]
