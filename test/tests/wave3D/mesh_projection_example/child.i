[Mesh]
  [ROI]
    type = GeneratedMeshGenerator
    dim = 2
    xmin = -15
    xmax =  15
    ymin = -15
    ymax =  15
    nx = 3
    ny = 3
  []
  parallel_type = REPLICATED
[]
[Problem]
  solve = false
[]

[AuxVariables]
  [Gr]
    order = FIRST
    family = LAGRANGE
  []
[]

[Executioner]
  type = Steady
[]

[Outputs]
  file_base = child
  exodus = true
  execute_on = TIMESTEP_END
[]
