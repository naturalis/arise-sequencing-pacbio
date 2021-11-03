#!/bin/bash

# dependencies:
# samtools
# zip

[ -d out_fastq ] && { printf "out_fastq EXISTS !!! \nplease remove to continue\n"; exit 1; }
mkdir -p out_fastq

for i in *.bam
do
   j=$(echo $i | rev | cut -c 5- | rev)
   samtools bam2fq "$i" > "$j".fastq
done

mv *.fastq out_fastq/
zip -m out_fastq/all_fastq.zip out_fastq/*.fastq
