[Mesh]
  [gmg]
    type = GeneratedMeshGenerator
    dim = 2
    nx = 10
    ny = 10
    xmin = -1
    xmax = 1
    ymin = -1
    ymax = 1
  []
[]

[Variables]
  [u]
  []
[]

[VectorPostprocessors]
  [src_values]
    type = CSVReader
    csv_file = source_params.csv
    header = true
    outputs=none
  []
[]

#[ICs]
#  [initial]
#    type = FunctionIC
#    variable = u
#    function = exact
#  []
#[]

[Kernels]
  [dt]
    type = TimeDerivative
    variable = u
  []
  [diff]
    type = Diffusion
    variable = u
  []
  [src]
    type = BodyForce
    variable = u
    function = source
  []
[]

[BCs]
  [dirichlet]
    type = DirichletBC
    variable = u
    boundary = 'left right top bottom'
    value = 0
  []
[]

[Functions]
  [exact]
    type = ParsedFunction
    value = '2*exp(-2.0*(x - sin(2*pi*t))^2)*exp(-2.0*(y - cos(2*pi*t))^2)*cos((1/2)*x*pi)*cos((1/2)*y*pi)/pi'
  []
  [source]
    type = VectorNearestPointFunction
    coord_x = src_values/coordx
    coord_y = src_values/coordy
    time = src_values/time
    value = src_values/values
  []
[]

[Executioner]
  type = Transient
  num_steps = 20
  end_time = 1
  solve_type = NEWTON
  petsc_options_iname = '-ksp_type -pc_type -pc_factor_mat_solver_package'
  petsc_options_value = 'preonly lu       superlu_dist'
  [TimeIntegrator]
    type = ImplicitEuler
  []
[]

[Reporters]
  [measured_data]
    type = OptimizationData
    measurement_file = mms_data.csv
    file_xcoord = x
    file_ycoord = y
    file_zcoord = z
    file_time = t
    file_value = u
    variable = u
    execute_on = timestep_end
    outputs = none
  []
[]

[Postprocessors]
  [p0]
    type = PointValue
    outputs = 'out'
    point = '.5 .5 0'
    variable = u
  []
  [p1]
    type = PointValue
    outputs = 'out'
    point = '.5 -.5 0'
    variable = u
  []
  [p2]
    type = PointValue
    outputs = 'out'
    point = '-.5 -.5 0'
    variable = u
  []
  [p3]
    type = PointValue
    outputs = 'out'
    point = '-.5 .5 0'
    variable = u
  []
  [p4]
    type = PointValue
    outputs = 'out'
    point = '.7 -.7 0'
    variable = u
  []
  [p5]
    type = PointValue
    outputs = 'out'
    point = '.4 -.6 0'
    variable = u
  []
  [p6]
    type = PointValue
    outputs = 'out'
    point = '.6 -.4 0'
    variable = u
  []
[]

[Outputs]
  exodus = false
  console = false
  [out]
    type = CSV
  []
[]
