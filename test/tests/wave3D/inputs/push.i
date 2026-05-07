[Kernels]
  [push]
    type = BodyForce
    variable = uzr
    value = 10
    function = exp(-((x-${ARFx})/${ARFxw}/6)^2-((y-${ARFy})/${ARFyw}/6)^2-((z-${ARFz})/${ARFzw}/6)^2)
  []
[]

