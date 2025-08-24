grid_size = 100
[Mesh]
  [ROI]
    type = GeneratedMeshGenerator
    dim = 2
    xmin = -10
    xmax =  10
    ymin = -10
    ymax =  10
    zmin = -10
    zmax =  10
    nx = ${grid_size}
    ny = ${grid_size}
    nz = ${grid_size}
  []
[]

[Problem]
  solve = false
[]

[AuxVariables]
  [uxr]
    family = LAGRANGE
    order  = FIRST
  []
  [uxi]
    family = LAGRANGE
    order  = FIRST
  []
  [uyr]
    family = LAGRANGE
    order  = FIRST
  []
  [uyi]
    family = LAGRANGE
    order  = FIRST
  []
  [uzr]
    family = LAGRANGE
    order  = FIRST
  []
  [uzi]
    family = LAGRANGE
    order  = FIRST
  []
[]

[UserObjects]
  [uzi]
    type = SolutionUserObject
    mesh = swe/swe300.e
    system_variables = 'uzi'
  []
[]

[AuxKernels]
  [AllVars]
    type = SolutionAux
    variable = 'uzi'
    solution = 'uzi'
  []
[]

[Executioner]
  type = Steady
[]

[Outputs]
  file_base = swe/swe300_${grid_size}
  exodus = true
  execute_on = TIMESTEP_END
[]
