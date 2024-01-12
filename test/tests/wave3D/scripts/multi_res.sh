rm -r measurement
cp -r synthetic measurement
cp inputs/GrGaussian.i inputs/GrMesh.i

cd inputs
../../../../isopod-opt -i GrMesh.i grid_size=3
cd ..

cp inputs/GrMesh3.e inputs/GrMesh.e
cp synthetic/measurements1_1.csv synthetic/measurements.csv
mpirun -np 1 ../../../isopod-opt -i invert.i maxiter=5
#rm measurement/frequencies.csv
mv inversion/GrMesh.e inversion/GrMesh3.e
mv inversion/GrMesh_OptimizationInfo_0001.csv inversion/Convergence3.csv
mv inversion/GrMesh_OptimizationReporter_0001.csv inversion/GrValues3.csv

../../../isopod-opt -i refine.i coarse_grid=3 fine_grid=6

cp inputs/GrMesh6.e inputs/GrMesh.e
cp synthetic/measurements1_1.csv synthetic/measurements.csv
mpirun -np 1 ../../../isopod-opt -i invert.i maxiter=5
#rm measurement/frequencies.csv
mv inversion/GrMesh.e inversion/GrMesh6.e
mv inversion/GrMesh_OptimizationInfo_0001.csv inversion/Convergence6.csv
mv inversion/GrMesh_OptimizationReporter_0001.csv inversion/GrValues6.csv

rm inputs/GrMesh.e
rm inputs/GrMesh.i
