# fine_grid = 6
# coarse_grid = 3
[Mesh]
  [ROI]
    type = GeneratedMeshGenerator
    dim = 2
    xmin = -15
    xmax =  15
    ymin = -15
    ymax =  15
    nx = ${fine_grid}
    ny = ${fine_grid}
  []
[]

[Problem]
  solve = false
[]

[AuxVariables]
  [Gr]
    family = LAGRANGE
    order  = FIRST
  []
[]

[UserObjects]
  [Gr]
    type = SolutionUserObject
    mesh = inversion/GrMesh${coarse_grid}.e
    system_variables = Gr
  []
[]

[AuxKernels]
  [Gr]
    type = SolutionAux
    variable = Gr
    solution = Gr
  []
[]

[Executioner]
  type = Steady
[]

[Outputs]
  file_base = inputs/GrMesh${fine_grid}
  exodus = true
  execute_on = TIMESTEP_END
[]
