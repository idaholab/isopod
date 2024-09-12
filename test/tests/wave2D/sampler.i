[StochasticTools]
[]
[Samplers]
  [frequencies]
    type = CSVSampler
    samples_file = 'measurement/frequencies.csv'
    column_names = 'id frequencyKHz'
    execute_on = 'PRE_MULTIAPP_SETUP'
    # nrows = 4
  []
[]
[MultiApps]
  [model_grad]
    type = SamplerFullSolveMultiApp
    input_files = model_grad.i
    sampler = frequencies
    ignore_solve_not_converge = true
    mode = normal
  []
[]
[Outputs]
  csv = false
  json = false
  console = false
  file_base = sampler/
[]

[Controls]
  [cmdLine]
    type = MultiAppSamplerControl
    multi_app = model_grad
    sampler = frequencies
    param_names = 'id frequencyKHz'
  []
[]

[Transfers]
  [setPrameters]
    type = MultiAppReporterTransfer
    to_multi_app = model_grad
    from_reporters = 'parameters/Gr'
    to_reporters = 'parameters/Gr'
    execute_on = 'TIMESTEP_BEGIN'
  []
  [ObjectivesGradients]
    type = SamplerReporterTransfer
    from_multi_app = model_grad
    sampler = frequencies
    stochastic_reporter = Results
    from_reporter = 'correlation/objective gradient/gradient'
  []
[]

[Reporters]
  [parameters]
    type = ConstantReporter
    real_vector_names = 'Gr'
    real_vector_values = '4.0 8.0 4.0'
  []
  [Results]
    type = StochasticReporter
    execute_on = 'INITIAL TIMESTEP_END' # do we need INITIAL
    parallel_type = ROOT
  []
  # [gradient]
  #   type = VectorOfVectorRowSum
  #   name = gradient
  #   reporter_vector_of_vectors = "Results/ObjectivesGradients:gradient:gradient"
  # []
  # [objective]
  #   type = VectorSum
  #   name = objective
  #   vector = "Results/ObjectivesGradients:correlation:objective"
  # []
  [objective]
    type = ParsedVectorRealReductionReporter
    name = objective
    reporter_name = "Results/ObjectivesGradients:correlation:objective"
    initial_value = 0
    expression = 'reduction_value+indexed_value'
  []
  [gradient]
    type = ParsedVectorVectorRealReductionReporter
    name = gradient
    reporter_name = "Results/ObjectivesGradients:gradient:gradient"
    initial_value = 0
    expression = 'reduction_value+indexed_value'
  []
[]
