# load libraries

library(stylo)
library(tools)

## load full corpus

# load all texts, make freq list and table of frequencies
set.all <- load.corpus.and.parse(corpus.dir="corpora/corpus_all", corpus.lang="French")
freq.list.all <- make.frequency.list(set.all, head=3000)
frq.table.all <- make.table.of.frequencies(corpus = set.all, features=freq.list.all)


# Dendrogram
result <- stylo(gui=FALSE, frequencies = frq.table.all, mfw.min=2000, mfw.max=2000, corpus.lang ="French", distance.measure="wurzburg",
                display.on.screen=FALSE, write.png.file = TRUE, plot.custom.height = 15, plot.font.size=6)

stylo(gui=FALSE, frequencies = frq.table.all, mfw.min=500, mfw.max=2500, corpus.lang ="French", distance.measure="wurzburg",
      display.on.screen=FALSE, analysis.type="BCT", write.png.file = TRUE, plot.custom.height = 9, plot.font.size=6)

## same with corpus more than 3 authors

set.3 <- load.corpus.and.parse(corpus.dir="corpora/more_than_3_samples", corpus.lang="French")
freq.list.3 <- make.frequency.list(set.3, head=3500)
frq.table.3 <- make.table.of.frequencies(corpus = set.3, features=freq.list.3)


# Dendrogram
result_dendo <- stylo(gui=FALSE, frequencies = frq.table.3, mfw.min=3500, mfw.max=3500, corpus.lang ="French", distance.measure="wurzburg",
                display.on.screen=FALSE, write.png.file = TRUE, plot.custom.height = 9, plot.font.size=6)

# BootStrap Consensus Tree
result_bct <- stylo(gui=FALSE, frequencies = frq.table.3, mfw.min=2000, mfw.max=4000, corpus.lang ="French", distance.measure="wurzburg",
      display.on.screen=FALSE, analysis.type="BCT", write.png.file = TRUE, plot.custom.height = 8, plot.font.size=6)


write.csv(result_dendo$distance.table, sprintf("distance_table_3500MFW_wurzburg_new.csv"), row.names = TRUE)