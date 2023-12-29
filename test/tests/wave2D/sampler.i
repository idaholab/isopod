[StochasticTools]
[]
[Samplers]
  [frequencies]
    type = CSVSampler
    samples_file = 'measurement/frequencies.csv'
    column_names = 'id frequencyKHz'
    execute_on = 'PRE_MULTIAPP_SETUP'
    min_procs_per_row = 2
  []
[]
[MultiApps]
  [model_grad]
    type = SamplerFullSolveMultiApp
    input_files = model_grad.i
    sampler = frequencies
    ignore_solve_not_converge = true
    mode = normal
    min_procs_per_app = 2
  []
[]
[Outputs]
  csv = false
  json = true
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
