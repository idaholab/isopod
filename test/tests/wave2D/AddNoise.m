function AddNoise(noiseIndB)
for i=1:4
    measTable = readtable(sprintf('measurement/frequency%d.csv',i));
    measTable.dummy =measTable.value;
    measTable.value = measTable.dummy.*(1+10^(-noiseIndB/20)*rand(size(measTable.dummy)));
    writetable(measTable,sprintf('measurement/frequency%d.csv',i));
end
end
