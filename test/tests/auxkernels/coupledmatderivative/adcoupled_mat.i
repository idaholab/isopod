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
  [v]
  []
[]

[AuxVariables]
  [dmat_du]
    family = MONOMIAL
    order = CONSTANT
  []
  [dmat_dv]
    family = MONOMIAL
    order = CONSTANT
  []
[]

[Kernels]
  [diff]
    type = Diffusion
    variable = u
  []
  [diff_v]
    type = Diffusion
    variable = v
  []
[]

[BCs]
  [left]
    type = DirichletBC
    variable = u
    value = 1e-8
    boundary = left
  []
  [right]
    type = DirichletBC
    variable = u
    value = 1
    boundary = right
  []
  [left_v]
    type = DirichletBC
    variable = u
    value = 1
    boundary = left
  []
  [right_v]
    type = DirichletBC
    variable = u
    value = 2
    boundary = right
  []
[]

[AuxKernels]
  [deriv_aux_u]
    type = ADCoupledVarMaterialDerivativeAux
    variable = dmat_du
    ad_prop_name = parsed_mat
    coupled_var = u
  []
  [deriv_aux_v]
    type = ADCoupledVarMaterialDerivativeAux
    variable = dmat_dv
    ad_prop_name = parsed_mat
    coupled_var = v
  []
[]

[Materials]
  [parsed_mat]
    type = ADParsedMaterial
    coupled_variables = 'u v'
    property_name = parsed_mat
    expression = '(u+v) + u*v + atan2(v,u)'
  []
  [parsed_mat_deriv_exact_u]
    type = ADParsedMaterial
    coupled_variables = 'u v'
    property_name = parsed_mat_deriv_exact_u
    expression = '1 + v - v / (u^2 + v^2)'
    output_properties = parsed_mat_deriv_exact_u
    outputs = exodus
  []
  [parsed_mat_deriv_exact_v]
    type = ADParsedMaterial
    coupled_variables = 'u v'
    property_name = parsed_mat_deriv_exact_v
    expression = '1 + u + u / (u^2 + v^2)'
    output_properties = parsed_mat_deriv_exact_v
    outputs = exodus
  []
[]

[Executioner]
  type = Steady
[]

[Postprocessors]
  [difference_u]
    type = ElementL2Difference
    variable = dmat_du
    other_variable = parsed_mat_deriv_exact_u
    execute_on = TIMESTEP_END
  []
  [difference_v]
    type = ElementL2Difference
    variable = dmat_dv
    other_variable = parsed_mat_deriv_exact_v
    execute_on = TIMESTEP_END
  []
[]

[Outputs]
  exodus = true
  execute_on = 'TIMESTEP_END'
[]
