# 400 Hz may be the max. Maybe even 300
rm -r /home/guddmurt/sawtooth/projects/isopod/test/tests/wave3D/measurement
cp -r /home/guddmurt/sawtooth/projects/isopod/test/tests/wave3D/synthetic /home/guddmurt/sawtooth/projects/isopod/test/tests/wave3D/measurement

cp /home/guddmurt/sawtooth/projects/isopod/test/tests/wave3D/inputs/GrGaussian.i /home/guddmurt/sawtooth/projects/isopod/test/tests/wave3D/inputs/GrMesh.i
/home/guddmurt/sawtooth/projects/isopod/isopod-opt -i /home/guddmurt/sawtooth/projects/isopod/test/tests/wave3D/inputs/GrMesh.i grid_size=12

mv /home/guddmurt/sawtooth/projects/isopod/test/tests/wave3D/GrMesh12.e /home/guddmurt/sawtooth/projects/isopod/test/tests/wave3D/inputs/GrMesh.e
mpirun -np 1 /home/guddmurt/sawtooth/projects/isopod/isopod-opt -i /home/guddmurt/sawtooth/projects/isopod/test/tests/wave3D/model.i frequencyKHz=0.300
tail -n +2 /home/guddmurt/sawtooth/projects/isopod/test/tests/wave3D/model/push1freq1_measure_data_0001.csv > /home/guddmurt/sawtooth/projects/isopod/test/tests/wave3D/synthetic/junk
cat /home/guddmurt/sawtooth/projects/isopod/test/tests/wave3D/synthetic/header /home/guddmurt/sawtooth/projects/isopod/test/tests/wave3D/synthetic/junk > /home/guddmurt/sawtooth/projects/isopod/test/tests/wave3D/synthetic/push1freq1.csv
rm /home/guddmurt/sawtooth/projects/isopod/test/tests/wave3D/synthetic/junk
rm /home/guddmurt/sawtooth/projects/isopod/test/tests/wave3D/inputs/GrMesh.i
rm -r /home/guddmurt/sawtooth/projects/isopod/test/tests/wave3D/measurement
