#!/bin/bash

JOBS=/short/xf1/src_big/nanopore-pipe/HPC_jobs
PROJ=/short/xf1/nanopore/Epauc


FASTQ_BASE=${PROJ}/fastq
FASTQ_CHOPPED=${FASTQ_BASE}/chopped
FASTQ_FILTERED=${FASTQ_BASE}/filtered




# make the output directory if not made already
if [ ! -d $FASTQ_FILTERED ]; then
        mkdir $FASTQ_FILTERED
fi


FASTQFILES=$(find $FASTQ_CHOPPED -name '*.fastq.gz')

for f in $FASTQFILES;
do
        echo $f
        SAMPLE=$(basename $f | cut -d '.' -f 1)
        OUTFILE=${FASTQ_FILTERED}/${SAMPLE}.chopped.filt.fastq.gz
        qsub -v INFILE=$f,OUTFILE=$OUTFILE,LEN=2000,Q=10 $JOBS/nanofilt.job
	#echo -v INFILE=$f,OUTFILE=$OUTFILE,LEN=2000,Q=10 $JOBS/nanofilt.job
done


