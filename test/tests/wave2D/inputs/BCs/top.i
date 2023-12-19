## BCs on the top boundary

# Tangential BC in x direction
  [uxrr_top]
    type = CoupledVarNeumannBC
    boundary = top
    variable = uxr
    v =        uxr
    coef = ${_Zsrr}
  []
  [uxri_top]
    type = CoupledVarNeumannBC
    boundary = top
    variable = uxr
    v =        uxi
    coef = ${_Zsri}
  []
  [uxir_top]
    type = CoupledVarNeumannBC
    boundary = top
    variable = uxi
    v =        uxr
    coef = ${_Zsir}
  []
  [uxii_top]
    type = CoupledVarNeumannBC
    boundary = top
    variable = uxi
    v =        uxi
    coef = ${_Zsii}
  []

# Normal BC in y direction
  [uyrr_top]
    type = CoupledVarNeumannBC
    boundary = top
    variable = uyr
    v =        uyr
    coef = ${_Znrr}
  []
  [uyri_top]
    type = CoupledVarNeumannBC
    boundary = top
    variable = uyr
    v =        uyi
    coef = ${_Znri}
  []
  [uyir_top]
    type = CoupledVarNeumannBC
    boundary = top
    variable = uyi
    v =        uyr
    coef = ${_Znir}
  []
  [uyii_top]
    type = CoupledVarNeumannBC
    boundary = top
    variable = uyi
    v =        uyi
    coef = ${_Znii}
  []

