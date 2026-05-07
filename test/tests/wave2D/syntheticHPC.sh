#PBS -N forwardModel
#!PBS -l nnodes=4
#!PBS -l select=7
#PBS -l select=10:ncpus=48:mpiprocs=48
#!:mem=128gb
#!PBS -l place=scatter:excl
#PBS -l walltime=0:30:00
#PBS -j oe
#PBS -P ne_ldrd
cp /home/guddmurt/sawtooth/projects/isopod/test/tests/wave2D/inputs/GrTrue_case2.i /home/guddmurt/sawtooth/projects/isopod/test/tests/wave2D/inputs/GrMesh.i
#! rm -r /home/guddmurt/sawtooth/projects/isopod/test/tests/wave2D/measurement
cp -r /home/guddmurt/sawtooth/projects/isopod/test/tests/wave2D/measurement_case2 /home/guddmurt/sawtooth/projects/isopod/test/tests/wave2D/measurement
/home/guddmurt/sawtooth/projects/isopod/isopod-opt -i /home/guddmurt/sawtooth/projects/isopod/test/tests/wave2D/inputs/GrMesh.i grid_size=12

cp /home/guddmurt/sawtooth/projects/isopod/test/tests/wave2D/inputs/GrMesh12.e /home/guddmurt/sawtooth/projects/isopod/test/tests/wave2D/inputs/GrMesh.e
mpirun -np 30 /home/guddmurt/sawtooth/projects/isopod/isopod-opt -i /home/guddmurt/sawtooth/projects/isopod/test/tests/wave2D/model_grad_direct.i id=1 frequencyKHz=0.100
rm -r /home/guddmurt/sawtooth/projects/isopod/test/tests/wave2D/measurement
