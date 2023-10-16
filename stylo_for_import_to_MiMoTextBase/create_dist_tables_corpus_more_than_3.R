# load libraries

library(stylo)
library(tools)


## corpus more than 3 authors

set.3 <- load.corpus.and.parse(corpus.dir="more_than_3_samples", corpus.lang="French")
freq.list.3 <- make.frequency.list(set.3)
frq.table.3 <- make.table.of.frequencies(corpus = set.3, features=freq.list.3)


# Dendrogram
result_dendo <- stylo(gui=FALSE, frequencies = frq.table.3, mfw.min=2000, mfw.max=2000, corpus.lang ="French", distance.measure="wurzburg",
                display.on.screen=FALSE, write.png.file = FALSE, plot.custom.height = 9, plot.font.size=6)


write.csv(result_dendo$distance.table, sprintf("distance_table_2000_MFW_wurzburg.csv"), row.names = TRUE)