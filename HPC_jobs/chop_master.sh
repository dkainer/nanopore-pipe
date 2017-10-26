#!/bin/bash

JOBS=/short/xf1/src_big/nanopore-pipe/HPC_jobs

FASTQ_BASE=/g/data1a/xf1/Epauc/nanopore/raw/albacore2
OUT_BASE=/short/xf1/nanopore/Epauc/fastq

FASTQ_CHOPPED=${OUT_BASE}/chopped
FASTQ_FILTERED=${OUT_BASE}/filtered


# make the output directory if not made already
if [ ! -d $FASTQ_CHOPPED ]; then
        mkdir $FASTQ_CHOPPED
fi


FASTQFILES=$(find $FASTQ_BASE -maxdepth 1 -name '*.fastq.gz')

for f in $FASTQFILES;
do
	echo $f
	SAMPLE=$(basename $f | cut -d '.' -f 1)
	OUTFILE=${FASTQ_CHOPPED}/${SAMPLE}.chopped.fastq.gz
	qsub -v INFILE=$f,OUTFILE=$OUTFILE $JOBS/porechop.job
done

