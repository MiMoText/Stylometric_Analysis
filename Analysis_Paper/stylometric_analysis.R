# load libraries

library(stylo)
library(tools)

corpus.directory = "corpora/testcorpus"

  # corpus_more_than_3_samples_Enfant_Mirabeau


# Step 1: Create Dendrogra, and BCT

## load texts, make freq list and table of frequencies with sub corpus

set.3 <- load.corpus.and.parse(corpus.dir=corpus.directory, corpus.lang="French")
freq.list.3 <- make.frequency.list(set.3, head=3500)
frq.table.3 <- make.table.of.frequencies(corpus = set.3, features=freq.list.3)


# Dendrogram
result_dendo <- stylo(gui=FALSE, frequencies = frq.table.3, mfw.min=3500, mfw.max=3500, corpus.lang ="French", distance.measure="wurzburg",
                      display.on.screen=FALSE, write.png.file = TRUE, plot.custom.height = 9, plot.font.size=6)

# BootStrap Consensus Tree
result_bct <- stylo(gui=FALSE, frequencies = frq.table.3, mfw.min=3000, mfw.max=3500, corpus.lang ="French", distance.measure="wurzburg",
                    display.on.screen=FALSE, analysis.type="BCT", write.png.file = TRUE, plot.custom.height = 8, plot.font.size=6)


write.csv(result_dendo$distance.table, sprintf("distance_table_3500MFW_wurzburg.csv"), row.names = TRUE)