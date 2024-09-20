alpha = 1e-4 #Regularization parameter (1e-4 worked well for illustrative example)

[StochasticTools]
[]

[MultiApps]
  [forward]
    type = FullSolveMultiApp
    input_files = 'sampler.i'
  []
  [regularizer]
    type = FullSolveMultiApp
    input_files = 'regularizer.i'
  []
[]

[Transfers]
  [SetParametersSampler]
    type = MultiAppReporterTransfer
    to_multi_app = forward
    from_reporters = 'parameters/Gr'
    to_reporters = 'parameters/Gr'
  []
  [SetParametersRegularizer]
    type = MultiAppReporterTransfer
    to_multi_app = regularizer
    from_reporters = 'parameters/Gr'
    to_reporters = 'parameters/Gr'
  []
  [GetObjectiveGradientSampler]
    type = MultiAppReporterTransfer
    from_multi_app = forward
    from_reporters = 'objective/objective
                      gradient/gradient'
    to_reporters = 'objOrig/objOrig
                    gradOrig/gradOrig'
  []
  [GetObjectiveGradientRegularizer]
    type = MultiAppReporterTransfer
    from_multi_app = regularizer
    from_reporters = 'objReg/objReg
                      gradReg/gradReg'
    to_reporters = 'objReg/objReg
                    gradReg/gradReg'
  []
[]

[Outputs]
  csv = false
  console = false
  json = false
  file_base = samplerReg/GrMesh
  execute_on = 'INITIAL TIMESTEP_END'
[]

[Reporters]

  [parameters]
    type = ConstantReporter
    real_vector_names = 'Gr'
    real_vector_values = '4.0' #dummy
  []

  [objOrig]
    type = ConstantReporter
    real_names = objOrig
    real_values = '4.0' #dummy
  []
  [objReg]
    type = ConstantReporter
    real_names = objReg
    real_values = '4.0' #dummy
  []
  [objective]
    type = ParsedScalarReporter
    name = objective
    reporter_names = 'objOrig/objOrig objReg/objReg'
    reporter_symbols = 'a b'
    expression = '1.0*a+${alpha}*b'
    execute_on = FINAL
  []

  [gradOrig]
    type = ConstantReporter
    real_vector_names = gradOrig
    real_vector_values = '4.0' #dummy
  []
  [gradReg]
    type = ConstantReporter
    real_vector_names = gradReg
    real_vector_values = '4.0' #dummy
  []
  [gradient]
    type = ParsedVectorReporter
    name = gradient
    reporter_names = 'gradOrig/gradOrig gradReg/gradReg'
    reporter_symbols = 'a b'
    expression = '1.0*a+${alpha}*b'
    execute_on = FINAL
  []

[]

