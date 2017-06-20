#!/bin/bash

JOBS=/short/xf1/src_big/nanopore-pipe/HPC_jobs
PROJ=/short/xf1/nanopore/test

FASTQ_BASE=$PROJ/fastq
FAST5_BASE=$PROJ/fast5
FAST5_FOLDERS=$(ls -d ${FAST5_BASE}/*)


# make the output directory if not made already
if [ ! -d $FASTQ_OUT ]; then
	mkdir $FASTQ_OUT
fi

# submit an albacore basecalling job for each folder of Fast5 data
for f in $FAST5_FOLDERS;
do
	echo qsub -v FAST5_BASE=$FAST5_BASE,FAST5_FOLDER=$(basename $f),FASTQ_BASE=$FASTQ_BASE $JOBS/albacore.job
	qsub -v FAST5_BASE=$FAST5_BASE,FAST5_FOLDER=$(basename $f),FASTQ_BASE=$FASTQ_BASE $JOBS/albacore.job
done
