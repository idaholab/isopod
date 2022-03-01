[Mesh]
  [fmg]
    type = FileMeshGenerator
    file = ./../halfSphere.e
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
  [p_var_forward]
    order = FIRST
    family = LAGRANGE
    block = 'bottom'
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

[Outputs]
  exodus = true
  csv = true
[]
