rm -r measurement
cp -r synthetic measurement

cp inputs/GrGaussian.i inputs/GrMesh.i
../../../isopod-opt -i inputs/GrMesh.i grid_size=12
mv GrMesh12.e inputs/GrMesh.e

mpirun -np 4 ../../../isopod-opt -i model_sampler.i
mv sampler/_model?_measure_data_0001.csv synthetic
rm inputs/GrMesh.i
rm -r measurement
