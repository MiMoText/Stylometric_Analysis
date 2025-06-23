#####
# This script was used for the analysis in a paper by Röttgermann, Konstanciak, Schöch.
#####

# load libraries

library(stylo)
library(tools)

##################################################################
# Preliminary step: find fitting setup parameters:
# use testcorpus with known authorship, create frequency list and frequency table
# it will be performed using different most frequent words (MFW) and 

test_MFW <- c(500, 1000, 1500, 2000, 2500, 3000, 3500)
test.set <- load.corpus.and.parse(corpus.dir="corpora/testcorpus", corpus.lang="French")
test.freq.list <- make.frequency.list(test.set, head=3500)
test.frq.table <- make.table.of.frequencies(corpus = test.set, features=test.freq.list)

for (mfw in test_MFW){
  test.result_dendo <- stylo(gui=FALSE, frequencies = test.frq.table, mfw.min=mfw, mfw.max=mfw, corpus.lang ="French", distance.measure="wurzburg", display.on.screen=FALSE, write.png.file = TRUE, plot.custom.height = 9, plot.font.size=6, path="results/testcorpus")
  write.csv(test.result_dendo$distance.table, sprintf("results/testcorpus/distance_table_%s_MFW_wurzburg_narrForm.csv", mfw), row.names = TRUE)
}
#################################################################

# Parameter:

corpus.directory = "corpora/corpus_more_than_3_samples_Enfant_Mirabeau" 
# other possible corpora are: narrativeForm

mfws = 2000 # for dendrogram

min.mfws.bct = 2000 # mfw.min for Bootstrap Consensus Tree
max.mfws.bct = 3500 # mfw.max for Bootstrap Consensus Tree


# path where plots will be saved
path.plots ="results/"

# Step 1: Create Dendrogram, and BCT

# Load texts, make frequency list and table of frequencies with chosen corpus

set <- load.corpus.and.parse(corpus.dir=corpus.directory, corpus.lang="French")
freq.list <- make.frequency.list(set, head=3500)
frq.table <- make.table.of.frequencies(corpus = set, features=freq.list)


# create dendrogram
result_dendo <- stylo(gui=FALSE, frequencies = frq.table, mfw.min=mfws, mfw.max=mfws, corpus.lang ="French", distance.measure="wurzburg",
                      display.on.screen=FALSE, write.png.file = TRUE, plot.custom.height = 9, plot.font.size=6, path= path.plots)

# BootStrap Consensus Tree
result_bct <- stylo(gui=FALSE, frequencies = frq.table, mfw.min=min.mfws.bct, mfw.max=max.mfws.bct, corpus.lang ="French", distance.measure="wurzburg",
                    display.on.screen=FALSE, analysis.type="BCT", write.png.file = TRUE, plot.custom.height = 8, plot.font.size=6, path = path.plots)


result_dendo$distance.table

# Save distance table
write.csv(result_dendo$distance.table, sprintf("results/dist_tables/distance_table_%s_MFW_wurzburg.csv", mfws), row.names = TRUE)
write.csv(result_bct$distance.table, sprintf("results/dist_tables/distance-table-bct-2000-3500-mfw.csv"), row.names = TRUE)


# Step 2: General Imposters Method
## taking 2000 MFWs
imposters2000 = imposters(reference.set = frq.table[-c(1), 1:2000], test = frq.table[1,1:2000], distance="wurzburg")
imposters2000


optim_imposters2000_w = imposters.optimize(frq.table[, 1:2000], distance="wurzburg")
optim_imposters2000_w


