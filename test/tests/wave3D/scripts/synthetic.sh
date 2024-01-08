# 400 Hz may be the max. Maybe even 300
rm -r measurement
cp -r synthetic measurement

cp inputs/GrGaussian.i inputs/GrMesh.i
/home/guddmurt/sawtooth/projects/isopod/isopod-opt -i inputs/GrMesh.i grid_size=12
mv GrMesh12.e inputs/GrMesh.e

mpirun -np 1 /home/guddmurt/sawtooth/projects/isopod/isopod-opt -i model.i frequencyKHz=0.300
tail -n +2 model/push1freq1_measure_data_0001.csv > synthetic/junk
cat synthetic/header synthetic/junk > synthetic/push1freq1.csv

rm synthetic/junk
rm inputs/GrMesh.i
rm -r measurement
