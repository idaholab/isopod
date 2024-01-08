rm -r measurement
cp -r synthetic measurement

cp inputs/GrGaussian.i inputs/GrMesh.i
../../../isopod-opt -i inputs/GrMesh.i grid_size=12
mv GrMesh12.e inputs/GrMesh.e

../../../isopod-opt -i model_sampler.i

rm inputs/GrMesh.i
rm -r measurement
