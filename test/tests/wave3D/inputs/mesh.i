[Mesh]
  [ROI]
    type = GeneratedMeshGenerator
    dim = 3
    xmin = -15
    xmax =  15
    ymin = -15
    ymax =  15
    zmin = -15
    zmax =  15
    nx = ${nelem}
    ny = ${nelem}
    nz = ${nelem}
    elem_type = HEX8
  []
[]

[VectorPostprocessors]
  [SWEreal]
    type = LineValueSampler
    start_point = ${SWE_xleft}
    end_point   = ${SWE_xright}
    num_points  = ${SWE_npoints}
    sort_by = x
    variable = uzr
  []
  [SWEimag]
    type = LineValueSampler
    start_point = ${SWE_xleft}
    end_point   = ${SWE_xright}
    num_points  = ${SWE_npoints}
    sort_by = x
    variable = uzi
  []
[]

