import numpy as np
import argparse
from nilearn import plotting
from nilearn import surface

parser = argparse.ArgumentParser()
parser.add_argument("SURFACE", help="file of the surface to plot the gene expression on (lh.white ; lh.pial ; lh.inflated)")
parser.add_argument("GENEMAP", help=".gii file of gene expression to project onto the surface")
parser.add_argument("--parc",help="file of a parcellation to use for smoothing")
parser.add_argument("--parc_rescale", help="Rescale after applying the parcellation, this emphasises the spatial variation but the actual measure isn't so interpretable",type=int)
args = parser.parse_args()

data=surface.load_surf_data(args.GENEMAP)

data_nonzero = np.extract(data>0,data)

min_value = min(data_nonzero)
max_value= max(data_nonzero)
scale_max=1
scale_min=0.0001

# Scale data to range
data_scaled = scale_min + (((data-min_value)/(max_value-min_value))*(scale_max-scale_min))

data_scaled[data == 0]=0

colorbar_on=True

# Average across parcels if a parcellation is provided
if args.parc:
    parc=surface.load_surf_data(args.parc)
    nparc=max(parc)
    for i in range(1, nparc+1):
        nverts = len(np.extract(parc==i,parc))
        data_scaled[parc == i] = sum(data_scaled[parc == i])/nverts
        if args.parc_rescale == 1:
            data_nonzero = np.extract(data_scaled>0,data_scaled)
            min_value = min(data_nonzero)
            max_value= max(data_nonzero)
            data_scaled = scale_min + (((data_scaled-min_value)/(max_value-min_value))*(scale_max-scale_min))
            data_scaled[data == 0]=0
            colorbar_on=False

thr_val = scale_min/2

view = plotting.view_surf(args.SURFACE, data_scaled,cmap='turbo', symmetric_cmap=False,threshold=thr_val,colorbar=colorbar_on)

view.open_in_browser()

# view.save_as_html("surface_plot.html")    
