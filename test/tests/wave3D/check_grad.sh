cp inputs/GrMesh_case2.i inputs/GrMesh.i
rm -r measurement
cp -r measurement_case2 measurement

cd inputs
../../../../isopod-opt -i GrMesh.i grid_size=2
cd ..

cp inputs/GrMesh2.e inputs/GrMesh.e
cp measurement/frequencies1_1.csv measurement/frequencies.csv
../../../isopod-opt -i check_grad.i

rm inputs/GrMesh.e
rm inputs/GrMesh.i
