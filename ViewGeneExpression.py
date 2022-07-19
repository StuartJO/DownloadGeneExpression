import numpy as np
import argparse
from nilearn import plotting

parser = argparse.ArgumentParser()
parser.add_argument("SURFACE", help="file of the surface to plot the gene expression on (lh.white ; lh.pial ; lh.inflated)")
parser.add_argument("GENEMAP", help=".gii file of gene expression to project onto the surface")
args = parser.parse_args()

#SURFACE='C:/Users/Stuart/Documents/ThalamicGradients/lh.white'

#GENEMAP='C:/Users/Stuart/Documents/ThalamicGradients/lh.gene793.gii'

view = plotting.view_surf(args.SURFACE, args.GENEMAP,cmap='viridis', symmetric_cmap=False)

view.open_in_browser()

# view.save_as_html("surface_plot.html")    