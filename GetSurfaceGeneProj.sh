#!/bin/env bash

DIR=""
GENE_LIST="${DIR}/AHBAEntrez.txt"

mkdir ${DIR}/GIFTI

ngene=$(wc -l ${GENE_LIST} | awk '{ print $1 }')

for IND in $(seq 1 $ngene); do
#for IND in 1; do
ID=$(sed -n "${IND}p" ${GENE_LIST})

# You can alternatively just run the following line outside the script. Whatever is easiest
mris_convert -f ${DIR}/${ID}/${ID}_mRNA_lh.mgh ${DIR}/lh.white ${DIR}/GIFTI/lh.geneID_${ID}.gii

done
