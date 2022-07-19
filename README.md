# DownloadGeneExpression
Get smoothed gene maps from Gryglewski et al

Hello Marti!

Here is some code to download and visualise gene expression maps. To run this code (for visualisation) you need to following modules installed:

numpy
nilearn

Plus any of the dependencies these require.

## Download files

Run

./GetDATA.sh PATH/TO/DOWNLOAD/DATA/TO TEXT/FILE/OF/GENES.txt

The first positional argument is the directory to download the files to, while the second should be a list of genes (labelled according to their Entrez IDs) to download. See AHBAEntrez.txt for an example.

## Visualise gene expression maps

To visualise the maps in a browser you can run the code like follows:

python ./ViewGeneExpression.py lh.white lh.geneID_793.gii

The surface you want to plot it on needs to be the first argument (either lh.white or lh.pial or lh.inflated) while the second is the gene expression map in .gii format. If you have downloaded lots of the gene expression maps, you can run GetSurfaceGeneProj.sh (note you will need to set it so DIR is the directory where all the unzip folders can be found and GENE_LIST is set to a text file containing a list of the Entrez IDs) to convert the required files to .gii. Alternatively just run (where GENEID is the Entrez IDs)

mris_convert -f ${GENEID}_mRNA_lh.mgh lh.white lh.geneID_${GENEID}.gii

Hopefully this works! The plotting code works for one gene at a time, if you want to just save out multiple maps quickly let me know and I can make that change.
