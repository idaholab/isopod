# Center the load at t=0 so that the push is purely real

[Kernels]
  [fxr]
    type = BodyForce
    variable = uxr
    function = ARFx
  []
  [fyr]
    type = BodyForce
    variable = uyr
    function = ARFy
  []
  [fzr]
    type = BodyForce
    variable = uzr
    function = ARFz
  []
[]

[Functions]
  [ARFx]
    type = PiecewiseMultilinear
    data_file = 'SWEmeas/ARF${push_id}x.txt'
  []
  [ARFy]
    type = PiecewiseMultilinear
    data_file = 'SWEmeas/ARF${push_id}y.txt'
  []
  [ARFz]
    type = PiecewiseMultilinear
    data_file = 'SWEmeas/ARF${push_id}z.txt'
  []
[]

