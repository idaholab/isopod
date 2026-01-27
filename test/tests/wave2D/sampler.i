[Problem]
  kernel_coverage_check = false
  solve = false
[]
[Executioner]
  type = Steady
[]
[Mesh]
  [generate]
    type = GeneratedMeshGenerator
    dim = 1
  []
[]

[MultiApps]
  [model_grad]
    type = FullSolveMultiApp
    input_files = model_grad.i
    min_procs_per_app = 1
    #positions is used to create the number of subapps
    positions_file = 'measurement/freq_positions.txt'
    cli_args_files = 'measurement/freq_cliArg.txt'
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
    type = MultiAppReporterTransfer
    from_multi_app = model_grad
    from_reporters = 'gradient/gradient correlation/objective'
    to_reporters = 'from_sub_rep/rec_vec_vec from_sub_rep/rec_vec'
    distribute_reporter_vector = true
  []
[]

[Reporters]
  [from_sub_rep]
    type = ConstantReporter
    real_vector_vector_names = 'rec_vec_vec'
    real_vector_vector_values = '0'
    real_vector_names = 'rec_vec'
    real_vector_values = "0."
    outputs = out
  []
  [parameters]
    type = ConstantReporter
    real_vector_names = 'Gr'
    real_vector_values = '4.0 8.0 4.0'
  []
  [objective]
    type = ParsedVectorRealReductionReporter
    name = objective
    reporter_name = from_sub_rep/rec_vec
    initial_value = 0
    expression = 'reduction_value+indexed_value'
  []
  [gradient]
    type = ParsedVectorVectorRealReductionReporter
    name = gradient
    reporter_name = "from_sub_rep/rec_vec_vec"
    initial_value = 0
    expression = 'reduction_value+indexed_value'
  []
[]

[Outputs]
  csv = false
  json = false
  console = false
  file_base = sampler/
[]
