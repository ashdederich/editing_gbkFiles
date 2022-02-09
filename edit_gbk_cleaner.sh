#!/bin/bash

grep "ORF" pseudo17978X4_NODE_1_length_432508_cov_27.928043.fasta.gbk_pseudos.gff | sed -n -e 's/^.*old_locus_tag=//p' > orf_file.txt

for tag in $(cat orf_file.txt); do
	awk -v i="$tag" ' {if(/locus_tag="i"/) sub(/gene=.*/,"gene=pseudogene",prev); print prev} {prev=$0} END{print prev}' 17978X4_NODE_1_length_432508_cov_27.928043.fasta.gbk > 17978X4_NODE_1_length_432508_cov_27.928043_pseudos.gbk;
done






























for i in $orf; do
	
	
	
awk -v i=$i 'NR>1{if(/locus_tag="/$i) sub(/gene=.*/,"gene=pseudogene",prev); print prev} {prev=$0} END{print prev}' ${gbkfile} > ${gbkfile}_pseudos.gbk



done

sed -i 's/pseudogene/"pseudogene"/g' ${gbkfile}_pseudos.gbk

frag=`grep "fragmentation" ${pseudofile} | sed -n -e 's/^.*old_locus_tag=//p' | awk -F "," '{print $1}'`

for i in $frag; do
	awk 'NR>1{if/locus_tag=$i/) sub(/gene=.*/,"gene=pseudogene",prev); print prev} {prev=$0} END{print prev}' ${gbkfile} > ${gbkfile}_pseudos.gbk
done

sed -i 's/pseudogene/"pseudogene"/g' ${gbkfile}_pseudos.gbk

#something I'm trying to get the for loop working with awk statement
awk '{for (a = 1; a<=NF; a++) {if(/locus_tag=/$a) sub(/gene=.*/,"gene=pseudogene",prev); print prev} {prev=$0} }'
