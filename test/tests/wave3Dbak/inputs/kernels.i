##########################################
### Structure appears correct          ###
### Examine the signs in materials.i   ###
### Confirm hte order of component and variables ###
### The order should be consistent with the materials signs ###
##########################################

[Kernels]
  [sigma_rr_x]
    type = ADStressDivergenceTensors
    volumetric_locking_correction = True
    displacements = 'uxr uyr uzr'
    component     =   0
    variable      =  uxr
    base_name = rr
  []
  [sigma_rr_y]
    type = ADStressDivergenceTensors
    volumetric_locking_correction = True
    displacements = 'uxr uyr uzr'
    component     =       1
    variable      =      uyr
    base_name = rr
  []
  [sigma_rr_z]
    type = ADStressDivergenceTensors
    volumetric_locking_correction = True
    displacements = 'uxr uyr uzr'
    component     =           2
    variable      =          uzr
    base_name = rr
  []

  [sigma_ri_x]
    type = ADStressDivergenceTensors
    volumetric_locking_correction = True
    displacements = 'uxr uyr uzr'
    component     =   0
    variable      =  uxi
    base_name = ri
  []
  [sigma_ri_y]
    type = ADStressDivergenceTensors
    volumetric_locking_correction = True
    displacements = 'uxr uyr uzr'
    component     =       1
    variable      =      uyi
    base_name = ri
  []
  [sigma_ri_z]
    type = ADStressDivergenceTensors
    volumetric_locking_correction = True
    displacements = 'uxr uyr uzr'
    component     =           2
    variable      =          uzi
    base_name = ri
  []

  [sigma_ir_x]
    type = ADStressDivergenceTensors
    volumetric_locking_correction = True
    displacements = 'uxi uyi uzi'
    component     =   0
    variable      =  uxr
    base_name = ir
  []
  [sigma_ir_y]
    type = ADStressDivergenceTensors
    volumetric_locking_correction = True
    displacements = 'uxi uyi uzi'
    component     =       1
    variable      =      uyr
    base_name = ir
  []
  [sigma_ir_z]
    type = ADStressDivergenceTensors
    volumetric_locking_correction = True
    displacements = 'uxi uyi uzi'
    component     =           2
    variable      =          uzr
    base_name = ir
  []

  [sigma_ii_x]
    type = ADStressDivergenceTensors
    volumetric_locking_correction = True
    displacements = 'uxi uyi uzi'
    component     =   0
    variable      =  uxi
    base_name = ii
  []
  [sigma_ii_y]
    type = ADStressDivergenceTensors
    volumetric_locking_correction = True
    displacements = 'uxi uyi uzi'
    component     =       1
    variable      =      uyi
    base_name = ii
  []
  [sigma_ii_z]
    type = ADStressDivergenceTensors
    volumetric_locking_correction = True
    displacements = 'uxi uyi uzi'
    component     =           2
    variable      =          uzi
    base_name = ii
  []


  [inertia_xr]
    type = Reaction
    rate = '${_rhow2}'
    variable = uxr
  []
  [inertia_yr]
    type = Reaction
    rate = '${_rhow2}'
    variable = uyr
  []
  [inertia_zr]
    type = Reaction
    rate = '${_rhow2}'
    variable = uzr
  []

  [inertia_xi]
    type = Reaction
    rate = '${_rhow2}'
    variable = uxi
  []
  [inertia_yi]
    type = Reaction
    rate = '${_rhow2}'
    variable = uyi
  []
  [inertia_zi]
    type = Reaction
    rate = '${_rhow2}'
    variable = uzi
  []
[]
