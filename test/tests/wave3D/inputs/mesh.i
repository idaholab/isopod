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
    elem_type = ${elemtype3D}
  []
[]

