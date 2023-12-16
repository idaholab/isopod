[Mesh]
  [ROI]
    type = GeneratedMeshGenerator
    dim = 3
    xmin = 0
    xmax = 30.0
    ymin = 0
    ymax = 30.0
    zmin = 0
    zmax = 30.0
    nx = 8
    ny = 8
    nz = 8
  []
  [receivers_plane]
    type = BoundingBoxNodeSetGenerator
    input = ROI
    new_boundary = 'rcv_points'
    top_right    = '15 22 30'
    bottom_left  = '15  0  0'
  []
[]

