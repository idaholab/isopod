cp inputs/GrTrue_case2.i inputs/GrMesh.i
cd inputs
../../../../isopod-opt -i GrMesh.i grid_size=12
cd ..

cp inputs/GrMesh12.e inputs/GrMesh.e
rm -r measurement
cp -r measurement_case2 measurement

../../../isopod-opt -i sampler_direct.i
rm inputs/GrMesh.i
rm -r measurement
