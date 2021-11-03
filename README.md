# arise-sequencing-pacbio
## data description
This repository documents initial attempts to consensus call PacBio pilot data.
The data was similar to the [ONT dataset](https://github.com/naturalis/arise-sequencing-nanopore) though
it contained some [additional material](https://docs.google.com/spreadsheets/d/11SVnGIaafMN7ybHoDktcJpbnDKnrdblw/edit#gid=776824571) (in total 95 insect specimens, 95 fungi samples and 92 marine specimens). Sequencing was outsourced to [LGTC](https://www.lumc.nl/org/lgtc/) (Leiden Genome Technology Center). Sequences were received in (unindexed) bam format, demultiplexed on forward and reverse barcode combinations. The data consisted of single reads (ie. no paired-end data).

|Dataset|Specimens|Marker|Passed|na|na|na|na|
|:---|:---:|:---:|:---:|:---:|:---:|:---:|:---:|
|insect|95|COI|95|-|-|-|-|
|marine|95|COI|90|-|-|-|-|
|fungi|92|ITS|71|-|-|-|-|

## split datasets
[extract_and_split.sh](https://github.com/naturalis/arise-sequencing-pacbio/blob/main/scripts/extract_and_split.sh)

## convert bam to fastq
[bam2fastq.sh](https://github.com/naturalis/arise-sequencing-pacbio/blob/main/scripts/bam2fq.sh)\
Quality scores seem to be corrupted(?) when converting bam to fastq using samtools. Possibly related to [this post](http://seqanswers.com/forums/showthread.php?t=77954). This issue might be solved by using [bam2fastx](https://github.com/PacificBiosciences/bam2fastx). For now, quality scores were left out of consideration, by converting the fastq files to fasta\
fq2fa.sh

## filter fastq by length (and quality)
For simplicity the consensus sequences are now created in Galaxy using DADA2 or Vsearch clustering algortihms (included in the "make otu table" tool). Because of this it makes sense to import the fastq files in Galaxy and do the filtering there as well.
Filtering by length in [some cases]() causes a significant reduction in the number of useable reads.
