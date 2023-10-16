import pandas as pd

with open("distance_table_2000_MFW_wurzburg.csv", "r", encoding="utf8") as infile:
    dist_table = pd.read_csv(infile, sep=",")


dist_table = dist_table.rename(columns={"Unnamed: 0" : "text_dist"})
print(dist_table.head())
anonym = dist_table[["text_dist", "Anonym_Enfant"]]
#print(anonym)

#print(anonym.min(skipna=True))
print(anonym.nsmallest(15, "Anonym_Enfant"))

#nerciat = dist_table[["text_dist", "Nerciat_Felicia"]]
#print(nerciat.nsmallest(10, "Nerciat_Felicia"))