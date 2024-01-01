[StochasticTools]
[]
[Samplers]
  [Gr]
    type = CSVSampler
    samples_file = 'plot_obj/Gr.csv'
    column_names = 'Gr'
    execute_on = 'PRE_MULTIAPP_SETUP'
    min_procs_per_row = 2
  []
[]
[MultiApps]
  [model_grad]
    type = SamplerFullSolveMultiApp
    input_files = model_grad.i
    sampler = Gr
    ignore_solve_not_converge = true
    mode = normal
    min_procs_per_app = 2
  []
[]
[Outputs]
  csv = true
  json = false
  console = false
  file_base = plot_obj/
[]

[Controls]
  [cmdLine]
    type = MultiAppSamplerControl
    multi_app = model_grad
    sampler = Gr
    param_names = 'Gr'
  []
[]

[Transfers]
  [ObjectivesGradients]
    type = SamplerReporterTransfer
    from_multi_app = model_grad
    sampler = Gr
    stochastic_reporter = Results
    from_reporter = 'correlation/objective gradient/gradient'
  []
[]

[Reporters]
  [parameters]
    type = ConstantReporter
    real_vector_names = 'Gr'
    #real_vector_values = '4.0 8.0 4.0'
    real_vector_values = '4.0'
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
