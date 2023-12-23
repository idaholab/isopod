############################################################
### Need to confirm that the signs used here are correct ###
###     Should the negative one be ri or ir?             ###
### Also, make sure that stress divergence tensor        ###
###     does not automatically revert -E to +E           ###
############################################################

[Materials]
  [storage_modulus]
    type = ADGenericFunctionMaterial
    prop_names = 'Er'
    prop_values = Er_dist
  []
  [loss_modulus]
    type = ADGenericFunctionMaterial
    prop_names = 'Ei'
    prop_values = Ei_dist
  []
  [minus_loss_modulus]
    type = ADGenericFunctionMaterial
    prop_names = '_Ei'
    prop_values = _Ei_dist
  []
  [poissons_ratio]
    type = ADGenericConstantMaterial
    prop_names = 'nu'
    prop_values = ${nu}
  []

  [Err]
    type = ADComputeVariableIsotropicElasticityTensor
    youngs_modulus = 'Er'
    poissons_ratio = '${nu}'#'nu'
    base_name = rr
  []
  [Eri]
    type = ADComputeVariableIsotropicElasticityTensor
    youngs_modulus = '_Ei' ######### CAUTION: Make sure that ADStressDivergenceTensor       ##########
                           ######### doesnt automatically MAKE THE NEGATIVE NUMBER POSITIVE ##########
    poissons_ratio = '${nu}'#'nu'
    base_name = ri
  []
  [Eir]
    type = ADComputeVariableIsotropicElasticityTensor
    youngs_modulus = 'Ei'
    poissons_ratio = '${nu}'#'nu'
    base_name = ir
  []
  [Eii]
    type = ADComputeVariableIsotropicElasticityTensor
    youngs_modulus = 'Er'
    poissons_ratio = '${nu}'#'nu'
    base_name = ii
  []

  [eps_rr]
    type = ADComputeSmallStrain
    volumetric_locking_correction = ${locking}
    displacements = 'uxr uyr'
    base_name = rr
  []
  [eps_ri]
    type = ADComputeSmallStrain
    volumetric_locking_correction = ${locking}
    displacements = 'uxr uyr'
    base_name = ri
  []
  [eps_ir]
    type = ADComputeSmallStrain
    volumetric_locking_correction = ${locking}
    displacements = 'uxi uyi'
    base_name = ir
  []
  [eps_ii]
    type = ADComputeSmallStrain
    volumetric_locking_correction = ${locking}
    displacements = 'uxi uyi'
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
