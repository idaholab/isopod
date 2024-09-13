#grid_size = 3
[Mesh]
  [ROI]
    type = GeneratedMeshGenerator
    dim = 2
    xmin = -15
    xmax = 15
    ymin = -15
    ymax = 15
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
    expression = 4+4*exp(-((x-0)/15)^2-((y-0)/15)^2)
    # expression = 7+4*exp(-((x-6)/15)^2-((y-6)/10)^2) #-2*exp(-((x+2)/5)^2-((y+2)/5)^2)
    # expression = 4+4*(1-(x/15)^2)*(1-(y/15)^2) # true value
    #expression = 4 # initial estimate
    execute_on = TIMESTEP_BEGIN
  []
[]

[VectorPostprocessors]
  [param_vec]
    type = NodalValueSampler
    sort_by = id
    variable = Gr
  []
[]

[Executioner]
  type = Steady
[]

[Outputs]
  file_base = GrMesh${grid_size}
  exodus = true
  csv = true
  execute_on = TIMESTEP_END
[]
