[VectorPostprocessors]
  [gradGrr]
    type = ElementOptimizationLameMuInnerProduct
    forward_strain_name = r_mechanical_strain_nonad
    adjoint_strain_name = r_adj_mechanical_strain_nonad
    variable = dummy
    function = Gr_func
    execute_on = ADJOINT_TIMESTEP_END
    execution_order_group = -1
  []
  [gradGri]
    type = ElementOptimizationLameMuInnerProduct
    forward_strain_name = i_mechanical_strain_nonad
    adjoint_strain_name = r_adj_mechanical_strain_nonad
    variable = dummy
    function = Gr_func
    execute_on = ADJOINT_TIMESTEP_END
    execution_order_group = -1
  []
  [gradGir]
    type = ElementOptimizationLameMuInnerProduct
    forward_strain_name = r_mechanical_strain_nonad
    adjoint_strain_name = i_adj_mechanical_strain_nonad
    variable = dummy
    function = Gr_func
    execute_on = ADJOINT_TIMESTEP_END
    execution_order_group = -1
  []
  [gradGii]
    type = ElementOptimizationLameMuInnerProduct
    forward_strain_name = i_mechanical_strain_nonad
    adjoint_strain_name = i_adj_mechanical_strain_nonad
    variable = dummy
    function = Gr_func
    execute_on = ADJOINT_TIMESTEP_END
    execution_order_group = -1
  []
  [gradGr]
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
  [gradGi]
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
  [gradG]
    type = VectorPostprocessorSum
    vectorpostprocessor_a = gradGr
    vectorpostprocessor_b = gradGi
    vector_name_a = gradGr
    vector_name_b = gradGi
    coef_a = 1.0
    coef_b = ${ve_factor}
    execute_on = ADJOINT_TIMESTEP_END
    execution_order_group = 1
  []
[]
