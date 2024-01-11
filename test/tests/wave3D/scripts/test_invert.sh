#PBS -N TestInverse3D
#PBS -l select=1:ncpus=4:mpiprocs=4
#PBS -l place=pack:excl
#PBS -l walltime=0:20:00
#PBS -j oe
#PBS -P ne_ldrd
cd $PBS_O_WORKDIR

rm -r measurement
cp -r synthetic measurement
cp inputs/GrGaussian.i inputs/GrMesh.i

../../../isopod-opt -i inputs/GrMesh.i grid_size=2
mv GrMesh2.e inputs/GrMesh.e

mpirun ../../../isopod-opt -i invert.i maxiter=2

rm inputs/GrMesh.i
rm -r measurement
