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
    nx = 30
    ny = 30
    nz = 30
  []
  [receivers_plane]
    type = BoundingBoxNodeSetGenerator
    input = ROI
    new_boundary = 'rcv_points'
    top_right    = '15 22 30'
    bottom_left  = '15  0  0'
  []
[]

