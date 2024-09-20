[Mesh]
  [ROI]
    type = FileMeshGenerator
    file = inputs/GrMesh.e
  []
[]

[AuxVariables]
  [Gr]
    family = LAGRANGE
    order  = FIRST
  []
[]
[AuxKernels]
  [SetGr]
    type = FunctionAux
    variable = Gr
    function = Gr_func
  []
[]
[Functions]
  [Gr_func]
    type = ParameterMeshFunction
    exodus_mesh = inputs/GrMesh.e
    parameter_name = parameters/Gr
  []
[]
[Reporters]
  [parameters]
    type = ConstantReporter
    real_vector_names = 'Gr'
    real_vector_values = '4 4 4 4 4 4 4 7 4 4 4 4 4 4 4 4'
  []
[]

[Variables]
  [dummy]
    family = LAGRANGE
    order  = FIRST
  []
[]
[Kernels]
  [Laplacian]
    type = MatDiffusion
    variable = dummy
    v = Gr
    diffusivity = 1.0
  []
  [dummy]
    type = Reaction
    variable = dummy
  []
[]

[AuxVariables]
  [gradReg]
    family = LAGRANGE
    order = FIRST
  []
[]
[AuxKernels]
  [saveResidual]
    type = DebugResidualAux
    debug_variable = dummy
    variable = gradReg
    execute_on = NONLINEAR
  []
[]

[VectorPostprocessors]
  [gradReg]
    type = NodalValueSampler
    variable = gradReg
    sort_by = id
  []
  [Gr]
    type = NodalValueSampler
    variable = Gr
    sort_by = id
  []
[]

[Reporters]
  [objVec]
    type = ParsedVectorReporter
    name = objVec
    reporter_names = 'gradReg/gradReg Gr/Gr'
    reporter_symbols = 'a b'
    expression = '0.5*a*b'
  []
  [objReg]
    type = ParsedVectorRealReductionReporter
    name = objReg
    reporter_name= objVec/objVec
    initial_value = 0
    expression = 'reduction_value+indexed_value'
  []
[]

[Executioner]
  type = Steady
  solve_type = NEWTON
  petsc_options_iname = '-pc_type'
  petsc_options_value = 'lu'
[]
[Outputs]
  file_base = regularizer/
  exodus = false
  csv = false
  console = false
[]
