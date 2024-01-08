grid_size = 100
[Mesh]
  [ROI]
    type = GeneratedMeshGenerator
    dim = 2
    xmin = -15
    xmax =  15
    ymin = -15
    ymax =  15
    zmin = -15
    zmax =  15
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
