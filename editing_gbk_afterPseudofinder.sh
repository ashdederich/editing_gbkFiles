#!/bin/bash

pseudofile=$1
gbkfile=$2
SAMPLEID=${gbkfile%.fasta.gbk}

grep "ORF" ${pseudofile} | sed -n -e 's/^.*old_locus_tag=//p' > orf_file.txt

for tag in $(cat orf_file.txt); do
	awk -v i="$tag" ' {if(/locus_tag="i"/) sub(/gene=.*/,"gene=pseudogene",prev); print prev} {prev=$0} END{print prev}' test_17978X4_NODE_1_length_432508_cov_27.928043.fasta.gbk > test_17978X4_NODE_1_length_432508_cov_27.928043_pseudos.gbk;
done

for tag in $(cat orf_file.txt); do
	awk -v i="$tag" '/locus_tag="i/{gsub(/gene=.*/,"gene=pseudogene",prev);h=0;if(prev)print prev;print;prev="";next} h{print prev} {prev=$0; h=1}' test_17978X4_NODE_1_length_432508_cov_27.928043.fasta.gbk > test_17978X4_NODE_1_length_432508_cov_27.928043_pseudos.gbk;
done

for tag in $(cat orf_file.txt); do
	tag2=\"$tag\"
	sed -n "/locus_tag=$tag2/{x;s/gene=.*/gene=pseudogene/;x};x;1!p;${x;p}" test_17978X4_NODE_1_length_432508_cov_27.928043.fasta.gbk > test_17978X4_NODE_1_length_432508_cov_27.928043_pseudos.gbk;
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