# DownloadGeneExpression
Get smoothed gene maps from Gryglewski et al

Hello Marti!

Here is some code to download and visualise gene expression maps. To run this code (for visualisation) you need to following modules installed:

numpy
nilearn

Plus any of the dependencies these require.

## Download files

To download a set of genes, run:

./GetDATA.sh PATH/TO/DOWNLOAD/DATA/TO TEXT/FILE/OF/GENES.txt

The first positional argument is the directory to download the files to, while the second should be a list of genes (labelled according to their Entrez IDs) to download. See AHBAEntrez.txt for an example.

## Visualise gene expression maps

To visualise the maps in a browser you can run the code like follows:

python ./ViewGeneExpression.py lh.white lh.geneID_793.gii

The surface you want to plot it on needs to be the first argument (either lh.white or lh.pial or lh.inflated) while the second is the gene expression map in .gii format. You can also input a parcellation to smooth the data (there are some artefacts in the data, you can see this polka dot type pattern across the cortex where some vertices gene expression is much higher/lower than their surroundings, unsure what causes this but it is some issue with how this data was processed. Averaging gene expression across a parcel will fix this to an extent). To input a parcellation you can run the following (I provided an example parcellation you can use)

python ./ViewGeneExpression.py lh.white lh.geneID_793.gii --parc lh.Schaefer_1000_7Net.annot

Because of the way that the code used by this function handles colourmaps, the gene expression will only cover a small range of the colourmap (the medial wall, which has an expression of 0, ruins all the fun). To emphasise the spatial variation of the gene expression do (this will only work if a parcellation is being used):

python ./ViewGeneExpression.py lh.white lh.geneID_793.gii --parc lh.Schaefer_1000_7Net.annot --parc_rescale

To convert the .mgh files to the .gii format, if you have downloaded lots of the gene expression maps, you can run GetSurfaceGeneProj.sh (note you will need to set it so DIR is the directory where all the unzip folders can be found and GENE_LIST is set to a text file containing a list of the Entrez IDs) to convert the required files to .gii. Alternatively just run (where GENEID is the Entrez IDs)

mris_convert -f ${GENEID}_mRNA_lh.mgh lh.white lh.geneID_${GENEID}.gii

Hopefully this works! The plotting code works for one gene at a time, if you want to just save out multiple maps quickly let me know and I can make that change.
