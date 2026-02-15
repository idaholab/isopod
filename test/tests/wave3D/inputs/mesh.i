[Mesh]
  [ROI]
    type = GeneratedMeshGenerator
    dim = 3
    xmin = -10
    xmax =  10
    ymin = -15
    ymax =  15
    zmin = -10
    zmax =  10
    nx = ${nelemx}
    ny = ${nelemy}
    nz = ${nelemz}
    elem_type = ${elemtype3D}
  []
[]

