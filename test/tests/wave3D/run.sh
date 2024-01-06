# Case 2. Make sure that inputs/GrMesh_case2.i has initial conditions set
rm -r measurement
cp -r measurement_case2 measurement
cp inputs/GrMesh_case2.i inputs/GrMesh.i

mamba activate moose

cd inputs
../../../../isopod-opt -i GrMesh.i grid_size=3
cd ..

cp inputs/GrMesh3.e inputs/GrMesh.e
cp measurement/frequencies1_1.csv measurement/frequencies.csv
../../../isopod-opt -i invert.i maxiter=20
rm measurement/frequencies.csv
mv inversion/GrMesh.e inversion/GrMesh3.e
mv inversion/GrMesh_OptimizationInfo_0001.csv inversion/Convergence3.csv
mv inversion/GrMesh_OptimizationReporter_0001.csv inversion/GrValues3.csv

../../../isopod-opt -i refine.i coarse_grid=3 fine_grid=6

cp inputs/GrMesh6.e inputs/GrMesh.e
cp measurement/frequencies1_2.csv measurement/frequencies.csv
../../../isopod-opt -i invert.i maxiter=20
rm measurement/frequencies.csv
mv inversion/GrMesh.e inversion/GrMesh6.e
mv inversion/GrMesh_OptimizationInfo_0001.csv inversion/Convergence6.csv
mv inversion/GrMesh_OptimizationReporter_0001.csv inversion/GrValues6.csv

../../../isopod-opt -i refine.i coarse_grid=6 fine_grid=12

cp inputs/GrMesh12.e inputs/GrMesh.e
cp measurement/frequencies1_3.csv measurement/frequencies.csv
../../../isopod-opt -i invert.i maxiter=20
rm measurement/frequencies.csv
mv inversion/GrMesh.e inversion/GrMesh12.e
mv inversion/GrMesh_OptimizationInfo_0001.csv inversion/Convergence12.csv
mv inversion/GrMesh_OptimizationReporter_0001.csv inversion/GrValues12.csv

rm inputs/GrMesh.e
rm inputs/GrMesh.i
