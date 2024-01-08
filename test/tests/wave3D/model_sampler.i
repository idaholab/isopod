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
    input_files = model.i
    sampler = measurements
    ignore_solve_not_converge = true
    mode = normal
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
    multi_app = model_grad
    sampler = measurements
    param_names = 'push_id freq_id ARFx ARFy ARFz frequencyKHz'
  []
[]

[Reporters]
  [Results]
    type = StochasticReporter
    execute_on = 'INITIAL TIMESTEP_END' # do we need INITIAL
    parallel_type = ROOT
  []
[]
