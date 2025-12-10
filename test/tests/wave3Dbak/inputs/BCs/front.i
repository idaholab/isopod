## BCs on the front boundary

# Tangential BC in x direction
  [uxrr_front]
    type = CoupledVarNeumannBC
    boundary = front
    variable = uxr
    v =        uxr
    coef = ${_Zsrr}
  []
  [uxri_front]
    type = CoupledVarNeumannBC
    boundary = front
    variable = uxr
    v =        uxi
    coef = ${_Zsri}
  []
  [uxir_front]
    type = CoupledVarNeumannBC
    boundary = front
    variable = uxi
    v =        uxr
    coef = ${_Zsir}
  []
  [uxii_front]
    type = CoupledVarNeumannBC
    boundary = front
    variable = uxi
    v =        uxi
    coef = ${_Zsii}
  []

# Tangential BC in y direction
  [uyrr_front]
    type = CoupledVarNeumannBC
    boundary = front
    variable = uyr
    v =        uyr
    coef = ${_Zsrr}
  []
  [uyri_front]
    type = CoupledVarNeumannBC
    boundary = front
    variable = uyr
    v =        uyi
    coef = ${_Zsri}
  []
  [uyir_front]
    type = CoupledVarNeumannBC
    boundary = front
    variable = uyi
    v =        uyr
    coef = ${_Zsir}
  []
  [uyii_front]
    type = CoupledVarNeumannBC
    boundary = front
    variable = uyi
    v =        uyi
    coef = ${_Zsii}
  []

# Normal BC in z direction
  [uzrr_front]
    type = CoupledVarNeumannBC
    boundary = front
    variable = uzr
    v =        uzr
    coef = ${_Znrr}
  []
  [uzri_front]
    type = CoupledVarNeumannBC
    boundary = front
    variable = uzr
    v =        uzi
    coef = ${_Znri}
  []
  [uzir_front]
    type = CoupledVarNeumannBC
    boundary = front
    variable = uzi
    v =        uzr
    coef = ${_Znir}
  []
  [uzii_front]
    type = CoupledVarNeumannBC
    boundary = front
    variable = uzi
    v =        uzi
    coef = ${_Znii}
  []
