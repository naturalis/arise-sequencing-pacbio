#!/bin/bash


[ -d out ] && { printf "out EXISTS !!! \nplease remove to continue\n"; exit 1; }
mkdir -p out

for fasta_file in $(ls *.fasta)
do
    j=$(echo $fasta_file | rev | cut -c 15- | rev)
    echo $j
    mafft --adjustdirection $fasta_file > out/"$j"mafft.fas
done

zip -m out/mafft.zip out/*.fas
