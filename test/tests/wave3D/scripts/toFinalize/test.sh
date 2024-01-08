# Need to change inputs/GrMesh_case?.i to true value
# Following is for case 2 - bell shaped inversion

cp inputs/GrMesh_case2.i inputs/GrMesh.i
rm -r measurement
cp -r measurement_case2 measurement

mamba activate moose

cd inputs
../../../../isopod-opt -i GrMesh.i grid_size=12
cd ..

cp inputs/GrMesh12.e inputs/GrMesh.e
cp measurement/frequencies1_3.csv measurement/frequencies.csv
../../../isopod-opt -i invert.i maxiter=20
rm measurement/frequencies.csv
mv inversion/GrMesh.e inversion/GrMesh12.e
mv inversion/GrMesh_OptimizationInfo_0001.csv inversion/Convergence12.csv
mv inversion/GrMesh_OptimizationReporter_0001.csv inversion/GrValues12.csv

rm inputs/GrMesh.e
rm inputs/GrMesh.i
