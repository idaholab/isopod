## BCs on the back boundary

# Tangential BC in x direction
  [uxrr_back]
    type = CoupledVarNeumannBC
    boundary = back
    variable = uxr
    v =        uxr
    coef = ${_Zsrr}
  []
  [uxri_back]
    type = CoupledVarNeumannBC
    boundary = back
    variable = uxr
    v =        uxi
    coef = ${_Zsri}
  []
  [uxir_back]
    type = CoupledVarNeumannBC
    boundary = back
    variable = uxi
    v =        uxr
    coef = ${_Zsir}
  []
  [uxii_back]
    type = CoupledVarNeumannBC
    boundary = back
    variable = uxi
    v =        uxi
    coef = ${_Zsii}
  []

# Tangential BC in y direction
  [uyrr_back]
    type = CoupledVarNeumannBC
    boundary = back
    variable = uyr
    v =        uyr
    coef = ${_Zsrr}
  []
  [uyri_back]
    type = CoupledVarNeumannBC
    boundary = back
    variable = uyr
    v =        uyi
    coef = ${_Zsri}
  []
  [uyir_back]
    type = CoupledVarNeumannBC
    boundary = back
    variable = uyi
    v =        uyr
    coef = ${_Zsir}
  []
  [uyii_back]
    type = CoupledVarNeumannBC
    boundary = back
    variable = uyi
    v =        uyi
    coef = ${_Zsii}
  []

# Normal BC in z direction
  [uzrr_back]
    type = CoupledVarNeumannBC
    boundary = back
    variable = uzr
    v =        uzr
    coef = ${_Znrr}
  []
  [uzri_back]
    type = CoupledVarNeumannBC
    boundary = back
    variable = uzr
    v =        uzi
    coef = ${_Znri}
  []
  [uzir_back]
    type = CoupledVarNeumannBC
    boundary = back
    variable = uzi
    v =        uzr
    coef = ${_Znir}
  []
  [uzii_back]
    type = CoupledVarNeumannBC
    boundary = back
    variable = uzi
    v =        uzi
    coef = ${_Znii}
  []
