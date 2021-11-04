# arise-sequencing-pacbio
## data description
This repository documents initial attempts to consensus call PacBio pilot data.
The data was similar to the [ONT dataset](https://github.com/naturalis/arise-sequencing-nanopore) though
it contained some [additional material](https://docs.google.com/spreadsheets/d/11SVnGIaafMN7ybHoDktcJpbnDKnrdblw/edit#gid=776824571) (in total 95 insect specimens, 95 fungi samples and 92 marine specimens). Sequencing was outsourced to [LGTC](https://www.lumc.nl/org/lgtc/) (Leiden Genome Technology Center). Sequences were received in (unindexed?) bam format, demultiplexed on forward and reverse barcode combinations. The data consisted of single reads (ie. no paired-end data).\
*Because the insect dataset had the highest number of passed reads, no fragment length variation issues and a proper reference dataset, the workflow will initially be tested with this dataset.*

|Dataset|Specimens|Marker|Passed|na|na|na|na|
|:---|:---:|:---:|:---:|:---:|:---:|:---:|:---:|
|insect|95|COI|95|-|-|-|-|
|marine|95|COI|90|-|-|-|-|
|fungi|92|ITS|71|-|-|-|-|

## split datasets
[extract_and_split.sh](https://github.com/naturalis/arise-sequencing-pacbio/blob/main/scripts/extract_and_split.sh)

## convert bam to fastq
[bam2fastq.sh](https://github.com/naturalis/arise-sequencing-pacbio/blob/main/scripts/bam2fq.sh)\
Quality scores seem to be corrupted(?) when converting bam to fastq using samtools. Possibly related to [this post](http://seqanswers.com/forums/showthread.php?t=77954). This issue might be solved by using [bam2fastx](https://github.com/PacificBiosciences/bam2fastx). For now, quality scores were left out of consideration, by converting the fastq files to fasta ([fq2fa.sh](https://github.com/naturalis/arise-sequencing-pacbio/blob/main/scripts/fq2fas.sh))

## filter fasta by length (and quality)
Sequences were filtered by length in Galaxy (ie. Prinseq) under the assumption that one of the clustering algorithms (DADA2, Vsearch) could be used for the creating consensus sequences. Trail and error showed that the variation within the sequences (ie. the number of obtained OTUs) was six fold (or more depending on noise and abundance parameters) higher than the number of specimens. So clustering as a method for consensus doesn't seem to be an option. For some of the input files filtering by length caused a severe reduction in the number of useable reads ([sequence trimmer log](https://github.com/naturalis/arise-sequencing-pacbio/blob/main/logs/sequence_trimmer_log.txt)).

## alignment and consensus
[Mafft.sh](https://github.com/naturalis/arise-sequencing-pacbio/blob/main/scripts/mafft.sh) was used to create an alignment for each filtered fasta file. These alignments were also saved as fasta and, of each, a consensus sequence was created with [consensus.pl](https://github.com/josephhughes/Sequence-manipulation).


## create a Blastdb from the insect.fas reference file
Blast the consensus sequences (put all in a single fasta file) against the ref db.

## remarks
Just as with the ONT data there seems to have been a mix-up of barcodes.\
Identifications (ie. specimen names) in the insect reference file (insect.fas) have been confirmed with a Blast search against the GenBank COI dataset in Galaxy.
