cp inputs/GrTrue_case2.i inputs/GrMesh.i
rm -r measurement
cp -r measurement_case2 measurement
cd inputs
../../../../isopod-opt -i GrMesh.i grid_size=12
cd ..

cp inputs/GrMesh12.e inputs/GrMesh.e
mpirun -np 16 ../../../isopod-opt -i model_grad_direct.i id=1 frequencyKHz=0.100
#../../../isopod-opt -i model_grad_direct.i id=2 frequencyKHz=0.200
#../../../isopod-opt -i model_grad_direct.i id=3 frequencyKHz=0.300
#../../../isopod-opt -i model_grad_direct.i id=4 frequencyKHz=0.400
mv outputs/1_measure_data_0001.csv measurement_case2/frequency1.csv
#mv outputs/2_measure_data_0001.csv measurement_case2/frequency2.csv
#mv outputs/3_measure_data_0001.csv measurement_case2/frequency3.csv
#mv outputs/4_measure_data_0001.csv measurement_case2/frequency4.csv
#rm -r outputs
rm -r measurement
