## BCs on the right boundary

# Normal BC in x direction
  [uxrr_right]
    type = CoupledVarNeumannBC
    boundary = right
    variable = uxr
    v =        uxr
    coef = ${_Znrr}
  []
  [uxri_right]
    type = CoupledVarNeumannBC
    boundary = right
    variable = uxr
    v =        uxi
    coef = ${_Znri}
  []
  [uxir_right]
    type = CoupledVarNeumannBC
    boundary = right
    variable = uxi
    v =        uxr
    coef = ${_Znir}
  []
  [uxii_right]
    type = CoupledVarNeumannBC
    boundary = right
    variable = uxi
    v =        uxi
    coef = ${_Znii}
  []

# Tangential BC in y direction
  [uyrr_right]
    type = CoupledVarNeumannBC
    boundary = right
    variable = uyr
    v =        uyr
    coef = ${_Zsrr}
  []
  [uyri_right]
    type = CoupledVarNeumannBC
    boundary = right
    variable = uyr
    v =        uyi
    coef = ${_Zsri}
  []
  [uyir_right]
    type = CoupledVarNeumannBC
    boundary = right
    variable = uyi
    v =        uyr
    coef = ${_Zsir}
  []
  [uyii_right]
    type = CoupledVarNeumannBC
    boundary = right
    variable = uyi
    v =        uyi
    coef = ${_Zsii}
  []

