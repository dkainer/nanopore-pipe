#!/bin/bash

JOBS=/short/xf1/src_big/nanopore-pipe/HPC_jobs

FASTQ_BASE=/g/data1a/xf1/Epauc/nanopore/raw/albacore2
OUT_BASE=/short/xf1/nanopore/Epauc/fastq

FASTQ_CHOPPED=${OUT_BASE}/chopped
FASTQ_FILTERED=${OUT_BASE}/filtered/Q10L1000
FASTQ_ASSEMBLE=${OUT_BASE}/assemble
FASTQ_VALIDATE=${OUT_BASE}/validate

# parse command line inputs VALPROP (proportion of reads to set aside as validation reads)
while getopts v: option
do
 case "${option}"
 in
 v) VALPROP=${OPTARG};;
 esac
done


# make the output directory if not made already
mkdir -p ${FASTQ_ASSEMBLE}
mkdir -p ${FASTQ_VALIDATE}

FASTQFILES=$(find $FASTQ_FILTERED -maxdepth 1  -name '*.fastq.gz')

for f in $FASTQFILES;
do
        echo $f
        SAMPLE=$(basename $f | cut -d '.' -f 1)	
	OUTFILE1=${FASTQ_VALIDATE}/${SAMPLE}.chopped.filt.val.fastq.gz
	OUTFILE2=${FASTQ_ASSEMBLE}/${SAMPLE}.chopped.filt.ass.fastq.gz

        qsub -v INFILE=$f,OUTFILE1=$OUTFILE1,OUTFILE2=$OUTFILE2,PROP=$VALPROP $JOBS/split_reads.job
#	echo qsub -v INFILE=$f,OUTFILE1=$OUTFILE1,OUTFILE2=$OUTFILE2,PROP=$VALPROP $JOBS/split_reads.job
done


