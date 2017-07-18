#!/bin/bash

JOBS=/short/xf1/src_big/nanopore-pipe/HPC_jobs
PROJ=/short/xf1/nanopore/Epauc


FASTQ_BASE=$PROJ/fastq
FASTQ_CHOPPED=$FASTQ_BASE/chopped
FASTQ_FILTERED=$FASTQ_BASE/filtered




# make the output directory if not made already
if [ ! -d $FASTQ_CHOPPED ]; then
        mkdir $FASTQ_CHOPPED
fi


FASTQFILES=$(find $FASTQ_BASE -name '*.fastq.gz')

for f in $FASTQFILES;
do
	echo $f
	SAMPLE=$(basename $f | cut -d '.' -f 1)
	OUTFILE=${FASTQ_CHOPPED}/${SAMPLE}.chopped.fastq.gz
	qsub -v INFILE=$f,OUTFILE=$OUTFILE $JOBS/porechop.job
done

