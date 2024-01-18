RES1=$(qsub scripts/res1.hpc)
RES2=$(qsub -W depend=afterok:$RES1 scripts/res2.hpc)
RES3=$(qsub -W depend=afterok:$RES2 scripts/res3.hpc)
