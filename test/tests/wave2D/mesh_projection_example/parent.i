[Mesh]
  [ROI]
    type = GeneratedMeshGenerator
    dim = 2
    xmin = -15
    xmax =  15
    ymin = -15
    ymax =  15
    nx = 2
    ny = 2
  []
  parallel_type = REPLICATED
[]
[Problem]
  solve = false
[]

[AuxVariables]
  [Gr_parent]
    order = FIRST
    family = LAGRANGE
  []
[]

[AuxKernels]
  [Gr_kernel]
    type = ParsedAux
    variable = Gr_parent
    use_xyzt = true
    expression = 4+4*(1-(x/15)^2)*(1-(y/15)^2)
    execute_on = TIMESTEP_BEGIN
  []
[]

[Executioner]
  type = Steady
[]

[Outputs]
  file_base = parent
  exodus = true
  execute_on = TIMESTEP_END
[]

[MultiApps]
  [child]
    type = FullSolveMultiApp
    execute_on = TIMESTEP_END
    input_files = child.i
  []
[]

[Transfers]
  [refine]
    type = MultiAppProjectionTransfer
    to_multi_app = child
    variable = Gr
    source_variable = Gr_parent
  []
[]
