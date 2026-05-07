## BCs on the bottom boundary

# Tangential BC in x direction
  [uxrr_bottom]
    type = ADCoupledVarNeumannBC
    boundary = bottom
    variable = uxr
    v =        uxr
    coef = ${_Zsrr}
  []
  [uxri_bottom]
    type = ADCoupledVarNeumannBC
    boundary = bottom
    variable = uxr
    v =        uxi
    coef = ${_Zsri}
  []
  [uxir_bottom]
    type = ADCoupledVarNeumannBC
    boundary = bottom
    variable = uxi
    v =        uxr
    coef = ${_Zsir}
  []
  [uxii_bottom]
    type = ADCoupledVarNeumannBC
    boundary = bottom
    variable = uxi
    v =        uxi
    coef = ${_Zsii}
  []

# Normal BC in y direction
  [uyrr_bottom]
    type = ADCoupledVarNeumannBC
    boundary = bottom
    variable = uyr
    v =        uyr
    coef = ${_Znrr}
  []
  [uyri_bottom]
    type = ADCoupledVarNeumannBC
    boundary = bottom
    variable = uyr
    v =        uyi
    coef = ${_Znri}
  []
  [uyir_bottom]
    type = ADCoupledVarNeumannBC
    boundary = bottom
    variable = uyi
    v =        uyr
    coef = ${_Znir}
  []
  [uyii_bottom]
    type = ADCoupledVarNeumannBC
    boundary = bottom
    variable = uyi
    v =        uyi
    coef = ${_Znii}
  []

