[VectorPostprocessors]
  [gradLrr]
    type = ElementOptimizationLameLambdaInnerProduct
    forward_strain_name = r_mechanical_strain_nonad
    adjoint_strain_name = r_adj_mechanical_strain_nonad
    variable = dummy
    function = Gr_func
    execute_on = ADJOINT_TIMESTEP_END
    execution_order_group = -1
  []
  [gradLri]
    type = ElementOptimizationLameLambdaInnerProduct
    forward_strain_name = i_mechanical_strain_nonad
    adjoint_strain_name = r_adj_mechanical_strain_nonad
    variable = dummy
    function = Gr_func
    execute_on = ADJOINT_TIMESTEP_END
    execution_order_group = -1
  []
  [gradLir]
    type = ElementOptimizationLameLambdaInnerProduct
    forward_strain_name = r_mechanical_strain_nonad
    adjoint_strain_name = i_adj_mechanical_strain_nonad
    variable = dummy
    function = Gr_func
    execute_on = ADJOINT_TIMESTEP_END
    execution_order_group = -1
  []
  [gradLii]
    type = ElementOptimizationLameLambdaInnerProduct
    forward_strain_name = i_mechanical_strain_nonad
    adjoint_strain_name = i_adj_mechanical_strain_nonad
    variable = dummy
    function = Gr_func
    execute_on = ADJOINT_TIMESTEP_END
    execution_order_group = -1
  []
  [gradLr]
    type = VectorPostprocessorSum
    vectorpostprocessor_a = gradLrr
    vectorpostprocessor_b = gradLii
    vector_name_a = inner_product
    vector_name_b = inner_product
    coef_a = 1.0
    coef_b = 1.0
    execute_on = ADJOINT_TIMESTEP_END
    execution_order_group = 0
  []
  [gradLi]
    type = VectorPostprocessorSum
    vectorpostprocessor_a = gradLri
    vectorpostprocessor_b = gradLir
    vector_name_a = inner_product
    vector_name_b = inner_product
    coef_a = -1.0
    coef_b =  1.0
    execute_on = ADJOINT_TIMESTEP_END
    execution_order_group = 0
  []
  [gradL]
    type = VectorPostprocessorSum
    vectorpostprocessor_a = gradLr
    vectorpostprocessor_b = gradLi
    vector_name_a = gradLr
    vector_name_b = gradLi
    coef_a = 1.0
    coef_b = ${ve_factor}
    execute_on = ADJOINT_TIMESTEP_END
    execution_order_group = 1
  []
[]
