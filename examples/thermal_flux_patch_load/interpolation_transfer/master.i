[Mesh]
  [fmg]
    type = FileMeshGenerator
    file = ./../halfSphere_coarse.e
  []
  [lowerd]
    input = fmg
    type = LowerDBlockFromSidesetGenerator
    sidesets = 'flat'
    new_block_id = 2
    new_block_name = "bottom"
  []
[]

[Variables]
  [u]
    order = FIRST
    family = LAGRANGE
  []
[]

[Kernels]
  [diff]
    type = Diffusion
    variable = u
  []
[]

[AuxVariables]
  [p_var]
    order = FIRST
    family = LAGRANGE
    block = 'bottom'
  []
[]

[AuxKernels]
  [p_var_kernel]
    type = FunctionAux
    variable = p_var
    function = aux_p_fun
  []
[]

[Functions]
  [aux_p_fun]
    type = ParsedFunction
    value = 10*sin(pi*y)*sin(pi*z)
  []
[]

[BCs]
  [./bottom]
    type = DirichletBC
    variable = u
    boundary = 'flat'
    value = 300
  [../]
[]

[Executioner]
  type = Steady
  solve_type = 'PJFNK'
  l_abs_tol = 1e-10
  nl_rel_tol = 1e-8
  nl_abs_tol = 1e-10
[]

[MultiApps]
  [forward]
    type = FullSolveMultiApp
    input_files = forward.i
    execute_on = 'TIMESTEP_END'
  []
[]

[Transfers]
  [to_forward_aux]
    type = MultiAppInterpolationTransfer
    # type = MultiAppNearestNodeTransfer
    direction = to_multiapp
    multi_app = forward
    source_variable = p_var
    variable = p_var_forward
  []
[]

[Outputs]
  csv = true
  exodus = true
[]
