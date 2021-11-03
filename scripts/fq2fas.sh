#!/bin/bash


for i in *.fastq
do
   j=$(echo $i | rev | cut -c 7- | rev)
   cat $i | sed -n '1~4s/^@/>/p;2~4p' > "$j".fas
done

zip -m all_fas.zip *.fas
