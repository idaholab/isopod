mamba activate moose

cd inputs
../../../../isopod-opt -i GrMesh.i grid_size=3
cd ..

mv inputs/GrMesh3.e inputs/GrMesh.e
cp measurement/frequencies1_1.csv measurement/frequencies.csv
../../../isopod-opt -i invert.i maxiter=20
rm measurement/frequencies.csv
mv inversion/GrMesh.e inversion/GrMesh3.e
mv inversion/GrMesh_OptimizationInfo_0001.csv inversion/Convergence3.csv
mv inversion/GrMesh_OptimizationReporter_0001.csv inversion/GrValues3.csv

../../../isopod-opt -i refine.i coarse_grid=3 fine_grid=6

mv inputs/GrMesh6.e inputs/GrMesh.e
cp measurement/frequencies1_2.csv measurement/frequencies.csv
../../../isopod-opt -i invert.i maxiter=20
rm measurement/frequencies.csv
mv inversion/GrMesh.e inversion/GrMesh6.e
mv inversion/GrMesh_OptimizationInfo_0001.csv inversion/Convergence6.csv
mv inversion/GrMesh_OptimizationReporter_0001.csv inversion/GrValues6.csv

../../../isopod-opt -i refine.i coarse_grid=6 fine_grid=12

mv inputs/GrMesh12.e inputs/GrMesh.e
cp measurement/frequencies1_3.csv measurement/frequencies.csv
../../../isopod-opt -i invert.i maxiter=20
rm measurement/frequencies.csv
mv inversion/GrMesh.e inversion/GrMesh12.e
mv inversion/GrMesh_OptimizationInfo_0001.csv inversion/Convergence12.csv
mv inversion/GrMesh_OptimizationReporter_0001.csv inversion/GrValues12.csv

rm inputs/GrMesh.e
