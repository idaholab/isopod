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

[AuxKernels]
  [Gr_kernel]
    type = ParsedAux
    variable = Gr
    use_xyzt = true
    expression = 4 #+4*(1-(x/15)^2)*(1-(y/15)^2)
    execute_on = TIMESTEP_BEGIN
  []
[]

[Executioner]
  type = Steady
[]

[Outputs]
  file_base = GrMesh
  exodus = true
  execute_on = TIMESTEP_END
[]
