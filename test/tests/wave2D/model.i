##########################################
### THE STRUCTURE IS PRETTY MUCH FINAL ###
##########################################

!include inputs/globals.i
!include inputs/mesh.i
!include inputs/variables.i
!include inputs/modulus.i
!include inputs/materials.i
!include inputs/kernels.i
!include inputs/push.i
#[BCs]
#  !include inputs/BCs/left.i
#  !include inputs/BCs/right.i
#  !include inputs/BCs/top.i
#  !include inputs/BCs/bottom.i
#[]

[Executioner]
  type = Steady
  solve_type = NEWTON # LINEAR
  petsc_options_iname = '-pc_type'
  petsc_options_value = 'lu'
  line_search = none
  automatic_scaling = true
[]

[Outputs]
    file_base = 'outputs/${id}'
    exodus = true
    csv = true
[]