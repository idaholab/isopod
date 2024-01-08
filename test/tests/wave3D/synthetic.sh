# 400 Hz may be the max. Maybe even 300
rm -r /home/guddmurt/sawtooth/projects/isopod/test/tests/wave3D/measurement
cp -r /home/guddmurt/sawtooth/projects/isopod/test/tests/wave3D/measurement_case2 /home/guddmurt/sawtooth/projects/isopod/test/tests/wave3D/measurement

cp /home/guddmurt/sawtooth/projects/isopod/test/tests/wave3D/inputs/GrTrue_case2.i /home/guddmurt/sawtooth/projects/isopod/test/tests/wave3D/inputs/GrMesh.i
/home/guddmurt/sawtooth/projects/isopod/isopod-opt -i /home/guddmurt/sawtooth/projects/isopod/test/tests/wave3D/inputs/GrMesh.i grid_size=12

cp /home/guddmurt/sawtooth/projects/isopod/test/tests/wave3D/inputs/GrMesh12.e /home/guddmurt/sawtooth/projects/isopod/test/tests/wave3D/inputs/GrMesh.e
mpirun -np 16 /home/guddmurt/sawtooth/projects/isopod/isopod-opt -i /home/guddmurt/sawtooth/projects/isopod/test/tests/wave3D/model_grad_direct.i id=1 frequencyKHz=0.300
mv /home/guddmurt/sawtooth/projects/isopod/test/tests/wave3D/outputs/1_measure_data_0001.csv /home/guddmurt/sawtooth/projects/isopod/test/tests/wave3D/measurement_case2/frequency1.csv
rm -r /home/guddmurt/sawtooth/projects/isopod/test/tests/wave3D/measurement
