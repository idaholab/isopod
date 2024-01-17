[Materials]
  [storage_modulus]
    type = ADGenericFunctionMaterial
    prop_names  = Er
    prop_values = Er_dist
  []
  [loss_modulus]
    type = ADGenericFunctionMaterial
    prop_names  = Ei
    prop_values = Ei_dist
  []
  [minus_loss_modulus]
    type = ADGenericFunctionMaterial
    prop_names  = _Ei
    prop_values = _Ei_dist
  []

  [Err]
    type = ADComputeVariableIsotropicElasticityTensor
    youngs_modulus = Er
    poissons_ratio = ${nu}
    base_name = rr
  []
  [Eri]
    type = ADComputeVariableIsotropicElasticityTensor
    youngs_modulus = _Ei
    poissons_ratio = ${nu}
    base_name = ri
  []
  [Eir]
    type = ADComputeVariableIsotropicElasticityTensor
    youngs_modulus = Ei
    poissons_ratio = ${nu}
    base_name = ir
  []
  [Eii]
    type = ADComputeVariableIsotropicElasticityTensor
    youngs_modulus = Er
    poissons_ratio = ${nu}
    base_name = ii
  []

  [eps_rr]
    type = ADComputeSmallStrain
    volumetric_locking_correction = ${locking}
    displacements = 'uxr uyr uzr'
    base_name = rr
  []
  [eps_ri]
    type = ADComputeSmallStrain
    volumetric_locking_correction = ${locking}
    displacements = 'uxi uyi uzi'
    base_name = ri
  []
  [eps_ir]
    type = ADComputeSmallStrain
    volumetric_locking_correction = ${locking}
    displacements = 'uxr uyr uzr'
    base_name = ir
  []
  [eps_ii]
    type = ADComputeSmallStrain
    volumetric_locking_correction = ${locking}
    displacements = 'uxi uyi uzi'
    base_name = ii
  []

  [sigma_rr]
    type = ADComputeLinearElasticStress
    base_name = rr
  []
  [sigma_ri]
    type = ADComputeLinearElasticStress
    base_name = ri
  []
  [sigma_ir]
    type = ADComputeLinearElasticStress
    base_name = ir
  []
  [sigma_ii]
    type = ADComputeLinearElasticStress
    base_name = ii
  []
[]
