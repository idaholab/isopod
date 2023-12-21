[Materials]
  [eps_rr_adj]
    type = ADComputeSmallStrain
    displacements = 'uxr_adj uyr_adj'
    base_name = 'rr_adj'
  []
  [eps_ri_adj]
    type = ADComputeSmallStrain
    displacements = 'uxr_adj uyr_adj'
    base_name = 'ri_adj'
  []
  [eps_ir_adj]
    type = ADComputeSmallStrain
    displacements = 'uxi_adj uyi_adj'
    base_name = 'ir_adj'
  []
  [eps_ii_adj]
    type = ADComputeSmallStrain
    displacements = 'uxi_adj uyi_adj'
    base_name = 'ii_adj'
  []
  [rr_mechanical_strain_nonad]
    type = RankTwoTensorMaterialADConverter
     ad_props_in  = rr_mechanical_strain
    reg_props_out = rr_mechanical_strain_nonad
  []
  [rr_adj_mechanical_strain_nonad]
    type = RankTwoTensorMaterialADConverter
     ad_props_in  = rr_adj_mechanical_strain
    reg_props_out = rr_adj_mechanical_strain_nonad
  []
  [ri_mechanical_strain_nonad]
    type = RankTwoTensorMaterialADConverter
     ad_props_in  = ri_mechanical_strain
    reg_props_out = ri_mechanical_strain_nonad
  []
  [ri_adj_mechanical_strain_nonad]
    type = RankTwoTensorMaterialADConverter
     ad_props_in  = ri_adj_mechanical_strain
    reg_props_out = ri_adj_mechanical_strain_nonad
  []
  [ir_mechanical_strain_nonad]
    type = RankTwoTensorMaterialADConverter
     ad_props_in  = ir_mechanical_strain
    reg_props_out = ir_mechanical_strain_nonad
  []
  [ir_adj_mechanical_strain_nonad]
    type = RankTwoTensorMaterialADConverter
     ad_props_in  = ir_adj_mechanical_strain
    reg_props_out = ir_adj_mechanical_strain_nonad
  []
  [ii_mechanical_strain_nonad]
    type = RankTwoTensorMaterialADConverter
     ad_props_in  = ii_mechanical_strain
    reg_props_out = ii_mechanical_strain_nonad
  []
  [ii_adj_mechanical_strain_nonad]
    type = RankTwoTensorMaterialADConverter
     ad_props_in  = ii_adj_mechanical_strain
    reg_props_out = ii_adj_mechanical_strain_nonad
  []
[]
