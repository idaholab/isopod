[AuxVariables]
  [dummy]
  []
[]

!include gradL.i
!include gradG.i

[VectorPostprocessors]
  [gradient]
    type = VectorPostprocessorSum
    vectorpostprocessor_a = gradG
    vectorpostprocessor_b = gradL
    vector_name_a = gradG
    vector_name_b = gradL
    coef_a = 1.0
    coef_b = 4.0 #2nu/(1-2nu)
    execute_on = ADJOINT_TIMESTEP_END
    execution_order_group = 1
  []
[]
