#!/bin/bash

JOBS=/short/xf1/src_big/nanopore-pipe/HPC_jobs

FASTQ_BASE=/g/data1a/xf1/Epauc/nanopore/raw/albacore2
OUT_BASE=/short/xf1/nanopore/Epauc/fastq

FASTQ_CHOPPED=${OUT_BASE}/chopped
FASTQ_FILTERED=${OUT_BASE}/filtered

# default values for Q and LEN
MINQ=10
MINLEN=1000

# parse command line inputs for Q and LEN
while getopts q:l: option
do
 case "${option}"
 in
 q) MINQ=${OPTARG};;
 l) MINLEN=${OPTARG};;
 esac
done


# make the output directory if not made already
mkdir -p $FASTQ_FILTERED/Q${MINQ}L${MINLEN}


FASTQFILES=$(find $FASTQ_CHOPPED -maxdepth 1  -name '*.fastq.gz')

for f in $FASTQFILES;
do
        echo $f
        SAMPLE=$(basename $f | cut -d '.' -f 1)
	OUTFILE=${FASTQ_FILTERED}/Q${MINQ}L${MINLEN}/${SAMPLE}.chopped.filt.fastq.gz
        qsub -v INFILE=$f,OUTFILE=$OUTFILE,LEN=$MINLEN,Q=$MINQ $JOBS/nanofilt.job
	#echo -v INFILE=$f,OUTFILE=$OUTFILE,LEN=$MINLEN,Q=$MINQ $JOBS/nanofilt.job
done


