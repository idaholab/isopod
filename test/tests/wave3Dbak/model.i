##########################################
### THE STRUCTURE IS PRETTY MUCH FINAL ###
##########################################

!include inputs/globals.i
!include inputs/mesh.i
!include inputs/variables.i
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
  solve_type = LINEAR
  petsc_options_iname = '-pc_type'
  petsc_options_value = 'lu'
[]

[Outputs]
    file_base = 'outputs/${id}'
    exodus = true
    csv = true
[]
