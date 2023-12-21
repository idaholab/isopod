[AuxVariables]
  [dummy]
  []
[]

[VectorPostprocessors]
  [gradGrr]
    type = ElementOptimizationLameMuInnerProduct
    forward_strain_name = 'rr_mechanical_strain_nonad'
    adjoint_strain_name = 'rr_adj_mechanical_strain_nonad'
    variable = dummy
    function = Gr_func # or just Gr
    execute_on = 'ADJOINT_TIMESTEP_END'
    execution_order_group = -1
  []
  [gradGri]
    type = ElementOptimizationLameMuInnerProduct
    forward_strain_name = 'ri_mechanical_strain_nonad'
    adjoint_strain_name = 'ri_adj_mechanical_strain_nonad'
    variable = dummy
    function = Gr_func # or just Gr
    execute_on = 'ADJOINT_TIMESTEP_END'
    execution_order_group = -1
  []
  [gradGir]
    type = ElementOptimizationLameMuInnerProduct
    forward_strain_name = 'ir_mechanical_strain_nonad'
    adjoint_strain_name = 'ir_adj_mechanical_strain_nonad'
    variable = dummy
    function = Gr_func # or just Gr
    execute_on = 'ADJOINT_TIMESTEP_END'
    execution_order_group = -1
  []
  [gradGii]
    type = ElementOptimizationLameMuInnerProduct
    forward_strain_name = 'ii_mechanical_strain_nonad'
    adjoint_strain_name = 'ii_adj_mechanical_strain_nonad'
    variable = dummy
    function = Gr_func # or just Gr
    execute_on = 'ADJOINT_TIMESTEP_END'
    execution_order_group = -1
  []
  [gradient_Gr]
    type = VectorPostprocessorSum
    vectorpostprocessor_a = gradGrr
    vectorpostprocessor_b = gradGii
    vector_name_a = inner_product
    vector_name_b = inner_product
    coef_a = 1.0
    coef_b = 1.0
    execute_on = ADJOINT_TIMESTEP_END
    execution_order_group = 0
  []
  [gradient_Gi]
    type = VectorPostprocessorSum
    vectorpostprocessor_a = gradGri
    vectorpostprocessor_b = gradGir
    vector_name_a = inner_product
    vector_name_b = inner_product
    coef_a = -1.0
    coef_b =  1.0
    execute_on = ADJOINT_TIMESTEP_END
    execution_order_group = 0
  []
  [gradient]
    type = VectorPostprocessorSum
    vectorpostprocessor_a = gradient_Gr
    vectorpostprocessor_b = gradient_Gi
    vector_name_a = gradient_Gr
    vector_name_b = gradient_Gi
    coef_a = 1.0
    coef_b = ${fparse omega/omega_bar}
    execute_on = ADJOINT_TIMESTEP_END
    execution_order_group = 1
  []
[]
