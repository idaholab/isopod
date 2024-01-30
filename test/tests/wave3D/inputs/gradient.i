[AuxVariables]
  [dummy]
  []
[]

!include gradL.i
!include gradG.i

[VectorPostprocessors]
  [gradientG]
    type = VectorPostprocessorSum
    vectorpostprocessor_a = gradG
    vectorpostprocessor_b = gradL
    vector_name_a = gradG
    vector_name_b = gradL
    coef_a = 1.0
    coef_b = ${dlambda_dmu} 
    execute_on = ADJOINT_TIMESTEP_END
    execution_order_group = 1
  []
[]
[Reporters]
  [gradient]
    type = ParsedVectorReporter
    name = gradient
    reporter_names = 'gradientG/gradientG Gr/Gr'
    reporter_symbols = 'gradientG Gr'
    expression = 'Gr*gradientG'
    execution_order_group = 2
    execute_on = ADJOINT_TIMESTEP_END
  []
[]
