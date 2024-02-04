##########################################
### THE STRUCTURE IS PRETTY MUCH FINAL ###
##########################################

[Problem]
  nl_sys_names = 'nl0 adjoint'
  kernel_coverage_check = false
[]
!include inputs/globals.i
dlambda_dmu   = ${fparse 2*nu/(1-2*nu)}
#dlambda_dmu   = -3
!include inputs/mesh.i
!include inputs/variables.i
!include inputs/modulus.i
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
!include inputs/measurements.i
!include inputs/adj_variables.i
!include inputs/adj_materials.i
!include inputs/adj_kernels.i
!include inputs/gradient.i

[Executioner]
  type = SteadyAndAdjoint
  forward_system = nl0
  adjoint_system = adjoint
  petsc_options_iname = ${petsc_name} #'-pc_type -tao_fd_test -tao_test_gradient -tao_fd_gradient'
  petsc_options_value = ${petsc_value} #'lu true true false'
  petsc_options = ${petsc_options} #'-tao_test_gradient_view'
  nl_forced_its = 1
  line_search = none
  nl_abs_tol = 1e-8
[]

[Outputs]
  exodus = false
  csv = true
  console = false
[]
