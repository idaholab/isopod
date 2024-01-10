rm -r measurement
cp -r synthetic measurement
cp inputs/GrGaussian.i inputs/GrMesh.i

../../../isopod-opt -i inputs/GrMesh.i grid_size=2
mv GrMesh2.e inputs/GrMesh.e

mpirun -np 2 ../../../isopod-opt -i invert_no_sampler.i maxiter=2

rm inputs/GrMesh.i
rm -r measurement
