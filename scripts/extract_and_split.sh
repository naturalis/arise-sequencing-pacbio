#!/bin/bash
unzip Naturalis-21025.zip
mv Naturalis-21025 bam
cd bam
mkdir insect fungi marine
mv *bc110[0-7].bam insect/
mv *--BC110[8-9].bam fungi/ && mv *--BC111[0-5].bam fungi/
mv *--BC111[6-9].bam marine/ && mv *--BC112[0-3].bam marine/
