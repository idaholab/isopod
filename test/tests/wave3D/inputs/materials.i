[Functions]
  [Er_dist]
    # type = PiecewiseMulticonstant
    # data_file = 'modulus/storage_modulus_dist.txt'
    # direction = 'left left left' # check this, it is also become 
                                 # available to define the centroid 
                                 # of the elements only.
    type = ParsedFunction
    value = 'if((((x-15)^2)+((y-15)^2)+((z-15)^2)) <= 0.049,80,25)'
  []
  [Ei_dist]
    type = ParsedFunction
    value = 'if((((x-15)^2)+((y-15)^2)+((z-15)^2)) <= 0.049,${fparse 80*(omega/omega_bar)} ,${fparse 25*(omega/omega_bar)})'
  []
[]

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
  [poissons_ratio]
    type = ADGenericConstantMaterial
    prop_names = 'nu'
    prop_values = 0.499999
  []

  [Err]
    type = ADComputeVariableIsotropicElasticityTensor
    youngs_modulus = 'Er'
    poissons_ratio = 'nu'
    base_name = rr
  []
  [Eri]
    type = ADComputeVariableIsotropicElasticityTensor
    youngs_modulus = 'Ei'   # '${fparse -Ei}' ######### CAUTION: Make sure that ADStressDivergenceTensor       ##########
                                     ######### doesnt automatically MAKE THE NEGATIVE NUMBER POSITIVE ##########
    poissons_ratio = 'nu'
    base_name = ri
  []
  [Eir]
    type = ADComputeVariableIsotropicElasticityTensor
    youngs_modulus = 'Ei'
    poissons_ratio = 'nu'
    base_name = ir
  []
  [Eii]
    type = ADComputeVariableIsotropicElasticityTensor
    youngs_modulus = 'Er'
    poissons_ratio = 'nu'
    base_name = ii
  []

  [eps_rr]
    type = ADComputeSmallStrain
    displacements = 'uxr uyr uzr'
    base_name = rr
  []
  [eps_ri]
    type = ADComputeSmallStrain
    displacements = 'uxi uyi uzi'
    base_name = ri
  []
  [eps_ir]
    type = ADComputeSmallStrain
    displacements = 'uxr uyr uzr'
    base_name = ir
  []
  [eps_ii]
    type = ADComputeSmallStrain
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
