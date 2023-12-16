# The push would needs to be applied on more refined mesh, 
# thus the need for mismatching mesh under the push.
# push information, location and amplitudes-this is changable 
# when we incorporate the fourier transformed push.
# in that case, we would need to loop over frequencies, 
# load the force from csv, in a similar to what we have in 
# the adjoint solve input.
[DiracKernels]
  [source_real_in_x1]
    type = ConstantPointSource
    point = '15 24 15'
    variable = uzr
    value = 10
  []
[]

