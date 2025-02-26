import pandas as pd
import seaborn as sns
from matplotlib import pyplot as plt
import os
from os.path import join

def make_clustermap(matrixfile):
    workdir = os.path.realpath(os.path.dirname(__file__))
    clustermapfile = join(workdir, "distance-matrix-clustermap.png")
    matrixfile="distance_table_2000_MFW_wurzburg.csv"

    matrix = pd.read_csv(matrixfile, sep=",", index_col=0)  # CSV mit Komma als Trennzeichen
        
    sns.set_style("whitegrid")
    plt.figure()
    plt.title("Cluster heatmap of stylometric distance matrix")
    
sns.clustermap(
        data=matrix,
        method="ward", # ward|centroid etc.
        robust=True,
        figsize=(18,18),
        annot=True,
        square=False,
        linewidths=0.8,
        linecolor="white",
        cmap="hot",
        cbar=True,    
        )
    
plt.tight_layout()
plt.savefig(clustermapfile, dpi=300)
plt.close()
print(f"Clustermap gespeichert als {clustermapfile}")

make_clustermap(matrixfile="distance_table_2000_MFW_wurzburg.csv")
