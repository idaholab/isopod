[Mesh]
  type = GeneratedMesh
  dim = 2
[]

[Variables]
  [u]
  []
[]

[Kernels]
  [null]
    type = NullKernel
    variable = u
  []
[]

[Reporters]
  [parameter_info]
    type = GriddedDataReporter
    parameter_file_names = 'diffusivity.txt'
    outputs = out
  []
[]

[Executioner]
  type = Steady
[]

[Outputs]
exodus=true
[]

