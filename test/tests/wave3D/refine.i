# fine_grid = 6
# coarse_grid = 3
[Mesh]
  [ROI]
    type = GeneratedMeshGenerator
    dim = 3
    xmin = -10
    xmax =  10
    ymin = -10
    ymax =  10
    zmin = -10
    zmax =  10
    nx = ${fine_grid}
    ny = ${fine_grid}
    nz = ${fine_grid}
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
