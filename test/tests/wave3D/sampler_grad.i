[StochasticTools]
[]
[Samplers]
  [measurements]
    type = CSVSampler
    samples_file = 'measurement/measurements.csv'
    column_names = 'push_id freq_id ARFx ARFy ARFz frequencyKHz'
    execute_on = 'PRE_MULTIAPP_SETUP'
  []
[]
[MultiApps]
  [model_grad]
    type = SamplerFullSolveMultiApp
    input_files = model_check_grad.i
    sampler = measurements
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
    sampler = measurements
    param_names = 'push_id freq_id ARFx ARFy ARFz frequencyKHz'
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
    sampler = measurements
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
  [gradient]
    type = VectorOfVectorRowSum
    name = gradient
    reporter_vector_of_vectors = "Results/ObjectivesGradients:gradient:gradient"
  []
  [objective]
    type = VectorSum
    name = objective
    vector = "Results/ObjectivesGradients:correlation:objective"
  []
[]
