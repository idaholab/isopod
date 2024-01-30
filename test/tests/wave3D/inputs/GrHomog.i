#grid_size = 3
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
    nx = ${grid_size}
    ny = ${grid_size}
    nz = ${grid_size}
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
  [logGr]
    order = FIRST
    family = LAGRANGE
  []
[]

[AuxKernels]
  [Gr_kernel]
    type = ParsedAux
    variable = Gr
    use_xyzt = true
    expression = 1
    execute_on = TIMESTEP_BEGIN
  []
  [logGr_kernel]
    type = ParsedAux
    variable = logGr
    use_xyzt = true
    expression = log(1)
    execute_on = TIMESTEP_BEGIN
  []
[]

[Executioner]
  type = Steady
[]

[Outputs]
  file_base = GrMesh${grid_size}
  exodus = true
  execute_on = TIMESTEP_END
[]
