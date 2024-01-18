rm -r measurement
cp -r synthetic measurement
cp inputs/GrGaussian.i inputs/GrMesh.i

../../../isopod-opt -i inputs/GrMesh.i grid_size=1
mv GrMesh1.e inputs/GrMesh.e

mpirun ../../../isopod-opt -i check_grad.i

rm inputs/GrMesh.i
rm -r measurement
