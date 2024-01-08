rm -r measurement
cp -r synthetic measurement
cp inputs/GrGaussian.i inputs/GrMesh.i

/home/guddmurt/sawtooth/projects/isopod/isopod-opt -i inputs/GrMesh.i grid_size=2
mv GrMesh2.e inputs/GrMesh.e

../../../isopod-opt -i invert.i maxiter=10

rm inputs/GrMesh.i
rm -r measurement
