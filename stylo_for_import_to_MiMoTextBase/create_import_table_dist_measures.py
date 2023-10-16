# Script for creating import table for importing distances between texts to the
# MiMoText-Base based on distance tables created in stylo() in R

import pandas as pd
from os.path import join

# path to distance table created with stylo() in R
dist_csv = "distance_table_2000_MFW_wurzburg.csv"

# path to xml-tei full metadata-table for renameing roman18-IDs to MiMoText-IDs
metadata_csv = join("..", "..", "roman18", "XML-TEI", "xml-tei_full_metadata.tsv")

# define how many closest text you want to extract
num_of_dists = 10

# save path
save_path = join("", "distance_table_for_import_2000_MFW.csv")

def open_csv(dist_csv, metadata_csv):

    with open(dist_csv, "r", encoding="utf8") as infile:
        dists = pd.read_csv(infile, sep=",", index_col="Unnamed: 0")
    #dists = dists.rename(columns={"Unnamed: 0": "text_name"})
    print(dists)

    with open(metadata_csv, "r", encoding="utf8") as infile:
        metadata = pd.read_csv(infile, sep="\t")
    return dists, metadata

def convert_ids(dists, metadata):
    metadata_name_ID_dict = metadata[["filename", "title_MiMoText-ID"]].set_index("filename").to_dict()
    #metadata_name_ID_dict = metadata_name_ID.to_dict()

    # rename index column
    dists = dists.rename(index=metadata_name_ID_dict["title_MiMoText-ID"])
    # rename column names
    dists = dists.rename(columns=metadata_name_ID_dict["title_MiMoText-ID"])
    return dists

def extract_dists(dists, num_of_dists):
    
    dist_dict={}
    for i, row in dists.iterrows():
        nsmallest = row.nsmallest(num_of_dists+1)
        dist_dict[i] = {}
        for n, num in nsmallest.items():
            if num != 0:
                dist_dict[i][n] = round(num, 4)

    return dist_dict

def create_dataframe(dist_dict):

    # create index list, it will be transposed later
    index_list = ["P49", "P49QP52"]
    for i in range(1,num_of_dists):
        index_list.append("{}P49".format(i))
        index_list.append("{}P49Q52".format(i))
    print(index_list)

    # create dataframe with final distances for import
    dists_df = pd.DataFrame(index=index_list)
    for qid, val in dist_dict.items():
        col_list = [item for t in list(val.items()) for item in t]
        dists_df[qid] = col_list
    

    print(dists_df)
    dists_df = dists_df.T.reset_index().rename(columns={"index": "QID"})
    print(dists_df)
    return dists_df

def save_df(save_path, dists_df):

    with open(save_path, "w", encoding="utf8", newline="\n") as outfile:
        dists_df.to_csv(outfile, sep=",", index=False)

def main(dist_csv, metadata_csv, num_of_dists, save_path):

    dists, metadata = open_csv(dist_csv, metadata_csv)
    
    # rename XXX_Etourdi as we listed it as Nerciat_Etourdi in metadata
    dists = dists.rename(columns={"XXX_Etourdi":"Nerciat_Etourdi"}, index={"XXX_Etourdi":"Nerciat_Etourdi"})

    # drop Neuville texts as we dont have them in the corpus
    #dists = dists.drop(columns=["Neufville_Confessions", "Neufville_Almanach_text_only"], index =["Neufville_Confessions", "Neufville_Almanach_text_only"])

    # convert roman18-IDs to MiMoText-Base-IDs:
    dists_qids = convert_ids(dists, metadata)
    
    # get the x closests texts
    dist_dict = extract_dists(dists_qids, num_of_dists)

    # create dataframe
    dists_df = create_dataframe(dist_dict)
    # save dataframe
    save_df(save_path,dists_df)

main(dist_csv, metadata_csv, num_of_dists, save_path)