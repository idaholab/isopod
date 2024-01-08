#ARFx = ((x-ARFxcenter)/ARFxw/6)
#ARFy = ((y-ARFycenter)/ARFyw/6)
#ARFz = ((z-ARFzcenter)/ARFzw/6)
[Kernels]
  [push]
    type = BodyForce
    variable = uzr
    value = 10
#    function = exp(-${ARFx}^2-${ARFy}^2-${ARFz}^2)
    function = exp(-((x-${ARFxcenter})/${ARFxw}/6)^2-((y-${ARFycenter})/${ARFyw}/6)^2-((z-${ARFzcenter})/${ARFzw}/6)^2)
  []
[]

