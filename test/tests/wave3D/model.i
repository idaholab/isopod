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

[VectorPostprocessors]
  [fieldvar]
    type = LineValueSampler
    variable = 'uxr uyr uzr uxi uyi uzi'
    start_point = '0 0 0'
    end_point = '20 20 20'
    num_points = '6'
    sort_by = 'x'
  []
[]

[Outputs]
    file_base = 'outputs/${id}'
    exodus = true
    csv = true
[]

[Executioner]
  type = Steady
  solve_type = LINEAR
  petsc_options_iname = '-pc_type'
  petsc_options_value = 'lu'
[]
