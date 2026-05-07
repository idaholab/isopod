# fine_grid = 6
# coarse_grid = 3
[Mesh]
  [ROI]
    type = GeneratedMeshGenerator
    dim = 3
    xmin = -10
    xmax =  10
    ymin = -15
    ymax =  15
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
  [logGr]
    family = LAGRANGE
    order  = FIRST
  []
[]

[UserObjects]
  [logGr]
    type = SolutionUserObject
    mesh = inversion/GrMesh${coarse_grid}.e
    system_variables = logGr
  []
[]

[AuxKernels]
  [logGr]
    type = SolutionAux
    variable = logGr
    solution = logGr
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
