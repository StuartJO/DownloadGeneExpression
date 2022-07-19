#!/bin/env bash

USE_MRTRIX=0;

if [ "${USE_MRTRIX}" == 1 ]; then 

module load mrtrix

fi

# Set directory where to save data
#DIR="/projects/hf49/Stuart/AHBA_wholebrain"
DIR=$1

# Location of genes according to Entrez ID
#GENE_LIST="${DIR}/AHBAEntrez.txt"
GENE_LIST=$2

# Set to 1 to put the data in compressed format. If compressed it will use up less space (duhhh) but if trying to access the data it will take longer.
# If uncompressed will take up space (duhhhhhhhh) but will be quick to access. Compression requires the use of MRtrix, although you can use any other software you want to do so
# 1 gene uncompressed is 16MB while compressed it is 4MB
COMPRESS=0

# Count the genes in the gene list
ngene=$(wc -l ${GENE_LIST} | awk '{ print $1 }')

# Loop over each gene
for IND in $(seq 1 $ngene); do
#for IND in 1; do
ID=$(sed -n "${IND}p" ${GENE_LIST})

# Site to download from
wget "http://www.meduniwien.ac.at/neuroimaging/genes/${ID}.zip"

# Unzip the file then recompress if needed
unzip ${DIR}/${ID}.zip -d ${DIR}/${ID}

rm ${DIR}/${ID}.zip


if [ "${USE_MRTRIX}" == 1 ]; then
if [ "${COMPRESS}" == 1 ]; then

mrconvert -quiet ${DIR}/${ID}/${ID}_mRNA.nii ${DIR}/${ID}/${ID}_mRNA.nii.gz -stride -1,2,3
mrconvert -quiet ${DIR}/${ID}/${ID}_mirr_mRNA.nii ${DIR}/${ID}/${ID}_mirr_mRNA.nii.gz -stride -1,2,3

rm ${DIR}/${ID}/${ID}_mRNA.nii
rm ${DIR}/${ID}/${ID}_mirr_mRNA.nii

fi

else

# To fix the strides to make sure all the data is in a consistent format (for my purposes), I copy the data, reformat it, then delete the copy
cp ${DIR}/${ID}/${ID}_mRNA.nii ${DIR}/${ID}/${ID}_mRNA2.nii
cp ${DIR}/${ID}/${ID}_mirr_mRNA.nii ${DIR}/${ID}/${ID}_mirr_mRNA2.nii
rm ${DIR}/${ID}/${ID}_mRNA.nii
rm ${DIR}/${ID}/${ID}_mirr_mRNA.nii
mrconvert -force -quiet ${DIR}/${ID}/${ID}_mRNA2.nii ${DIR}/${ID}/${ID}_mRNA.nii -stride -1,2,3
mrconvert -force -quiet ${DIR}/${ID}/${ID}_mirr_mRNA2.nii ${DIR}/${ID}/${ID}_mirr_mRNA.nii -stride -1,2,3
rm ${DIR}/${ID}/${ID}_mRNA2.nii
rm ${DIR}/${ID}/${ID}_mirr_mRNA2.nii
fi

fi

done

