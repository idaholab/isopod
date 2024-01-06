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
    elem_type = HEX27
  []
[]

[VectorPostprocessors]
  [measurement_line]
    type = LineValueSampler
    start_point = '0 0 0'
    end_point = '15 0 0'
    num_points = 10
    sort_by = x
    variable = uzr
  []
[]

