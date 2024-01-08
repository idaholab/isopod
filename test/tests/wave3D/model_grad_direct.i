##########################################
### THE STRUCTURE IS PRETTY MUCH FINAL ###
##########################################

!include inputs/globals_direct.i
!include inputs/mesh.i
!include inputs/variables.i
!include inputs/modulus_direct.i
!include inputs/materials.i
!include inputs/kernels.i
!include inputs/push.i
[BCs]
  !include inputs/BCs/left.i
  !include inputs/BCs/right.i
  !include inputs/BCs/top.i
  !include inputs/BCs/bottom.i
  !include inputs/BCs/front.i
  !include inputs/BCs/back.i
[]

[Executioner]
  type = Steady
  solve_type = NEWTON
  petsc_options_iname = '-pc_type'
  petsc_options_value = 'lu'
  nl_forced_its = 1
  line_search = none
  nl_abs_tol = 1e-8
[]

[Outputs]
 file_base = 'swe/${id}'
  exodus = true
  csv = true
  console = true
  execute_on = TIMESTEP_END
[]
