####
# Script for calculating the n-smallest distances in the stylometric analysis results.
# Input: Distance table created during stylometric analysis using stylo in R.
# Output: texts that have the closest distances to "L'Enfant du bordel".
####

import pandas as pd

# Using distance table created for Dendrogram
with open("results/dist_tables/distance_table_2000_MFW_wurzburg.csv", "r", encoding="utf8") as infile:
    dist_table = pd.read_csv(infile, sep=",")


dist_table = dist_table.rename(columns={"Unnamed: 0" : "text_dist"})
print(dist_table.head())
anonym = dist_table[["text_dist", "Anonym_Enfant"]]


print(anonym.nsmallest(16, "Anonym_Enfant"))


# Using distance table created for Bootstrap Consensus Tree

with open("results/dist_tables/distance-table-bct-2000-3500-mfw.csv", "r", encoding="utf8") as infile:
    dist_table_bct = pd.read_csv(infile, sep=",")


dist_table_bct = dist_table_bct.rename(columns={"Unnamed: 0" : "text_dist"})
anonym_bct = dist_table_bct[["text_dist", "Anonym_Enfant"]]
#print(anonym)

print("BCT")
print(anonym_bct.nsmallest(16, "Anonym_Enfant"))