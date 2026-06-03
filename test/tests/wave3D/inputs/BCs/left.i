## BCs on the left boundary

# Normal BC in x direction
  [uxrr_left]
    type = ADCoupledVarNeumannBC
    boundary = left
    variable = uxr
    v =        uxr
    coef = ${_Znrr}
  []
  [uxri_left]
    type = ADCoupledVarNeumannBC
    boundary = left
    variable = uxr
    v =        uxi
    coef = ${_Znri}
  []
  [uxir_left]
    type = ADCoupledVarNeumannBC
    boundary = left
    variable = uxi
    v =        uxr
    coef = ${_Znir}
  []
  [uxii_left]
    type = ADCoupledVarNeumannBC
    boundary = left
    variable = uxi
    v =        uxi
    coef = ${_Znii}
  []

# Tangential BC in y direction
  [uyrr_left]
    type = ADCoupledVarNeumannBC
    boundary = left
    variable = uyr
    v =        uyr
    coef = ${_Zsrr}
  []
  [uyri_left]
    type = ADCoupledVarNeumannBC
    boundary = left
    variable = uyr
    v =        uyi
    coef = ${_Zsri}
  []
  [uyir_left]
    type = ADCoupledVarNeumannBC
    boundary = left
    variable = uyi
    v =        uyr
    coef = ${_Zsir}
  []
  [uyii_left]
    type = ADCoupledVarNeumannBC
    boundary = left
    variable = uyi
    v =        uyi
    coef = ${_Zsii}
  []

# Tangential BC in z direction
  [uzrr_left]
    type = ADCoupledVarNeumannBC
    boundary = left
    variable = uzr
    v =        uzr
    coef = ${_Zsrr}
  []
  [uzri_left]
    type = ADCoupledVarNeumannBC
    boundary = left
    variable = uzr
    v =        uzi
    coef = ${_Zsri}
  []
  [uzir_left]
    type = ADCoupledVarNeumannBC
    boundary = left
    variable = uzi
    v =        uzr
    coef = ${_Zsir}
  []
  [uzii_left]
    type = ADCoupledVarNeumannBC
    boundary = left
    variable = uzi
    v =        uzi
    coef = ${_Zsii}
  []
