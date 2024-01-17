[Mesh]
  [ROI]
    type = GeneratedMeshGenerator
    dim = 3
    xmin = -10
    xmax =  10
    ymin = -10
    ymax =  10
    zmin = -10
    zmax =  10
    nx = ${nelem}
    ny = ${nelem}
    nz = ${nelem}
    elem_type = ${elemtype3D}
  []
[]

