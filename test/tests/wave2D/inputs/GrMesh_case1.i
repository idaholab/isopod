#grid_size = 3
[Mesh]
  [ROI]
    type = GeneratedMeshGenerator
    dim = 2
    xmin = -15
    xmax =  15
    ymin = -15
    ymax =  15
    nx = ${grid_size}
    ny = ${grid_size}
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

[AuxKernels]
  [Gr_kernel]
    type = ParsedAux
    variable = Gr
    use_xyzt = true
   #expression = 4 # true value
    expression = 3 # initial value
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
