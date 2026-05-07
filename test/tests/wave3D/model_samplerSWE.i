[StochasticTools]
[]
[Samplers]
  [measurements]
    type = CSVSampler
    samples_file = 'SWEmeas/acquisitions.csv'
    column_names = 'push_id frequencyDeciHz'
    execute_on = 'PRE_MULTIAPP_SETUP'
  []
[]
[MultiApps]
  [model]
    type = SamplerFullSolveMultiApp
    input_files = modelSWE.i
    sampler = measurements
    ignore_solve_not_converge = false
    mode = batch-reset #changed from normal after the hack
  []
[]
[Outputs]
  csv = true
  json = false
  console = true
  file_base = sampler/
[]

[Controls]
  [cmdLine]
    type = MultiAppSamplerControl
    multi_app = model
    sampler = measurements
    param_names = 'push_id frequencyDeciHz'
  []
[]

[Reporters]
  [Results]
    type = StochasticReporter
    execute_on = 'INITIAL TIMESTEP_END' # do we need INITIAL
    parallel_type = ROOT
  []
[]
