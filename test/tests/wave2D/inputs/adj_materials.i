[Materials]
  [eps_r_adj]
    type = ADComputeSmallStrain
    volumetric_locking_correction = ${locking}
    displacements = 'uxr_adj uyr_adj'
    base_name = r_adj
  []
  [eps_i_adj]
    type = ADComputeSmallStrain
    volumetric_locking_correction = ${locking}
    displacements = 'uxi_adj uyi_adj'
    base_name = i_adj
  []
  [r_mechanical_strain_nonad]
    type = RankTwoTensorMaterialADConverter
     ad_props_in  = rr_mechanical_strain
    reg_props_out =  r_mechanical_strain_nonad
  []
  [r_adj_mechanical_strain_nonad]
    type = RankTwoTensorMaterialADConverter
     ad_props_in  =  r_adj_mechanical_strain
    reg_props_out =  r_adj_mechanical_strain_nonad
  []
  [i_mechanical_strain_nonad]
    type = RankTwoTensorMaterialADConverter
     ad_props_in  = ii_mechanical_strain
    reg_props_out =  i_mechanical_strain_nonad
  []
  [i_adj_mechanical_strain_nonad]
    type = RankTwoTensorMaterialADConverter
     ad_props_in  =  i_adj_mechanical_strain
    reg_props_out =  i_adj_mechanical_strain_nonad
  []
[]
