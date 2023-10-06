# load libraries
library(stylo)
library(tools)

## load full corpus

# same with corpus more than 3 authors in narrative Form

set.3 <- load.corpus.and.parse(corpus.dir="../corpora/corpus_with_narr_form", corpus.lang="French")
freq.list.3 <- make.frequency.list(set.3, head=4000)
frq.table.3 <- make.table.of.frequencies(corpus = set.3, features=freq.list.3)


# Dendrogram
result <- stylo(gui=FALSE, frequencies = frq.table.3, mfw.min=3500, mfw.max=3500, corpus.lang ="French", distance.measure="wurzburg",
                display.on.screen=FALSE, write.png.file = TRUE, plot.custom.height = 9, plot.font.size=6)
                

stylo(gui=FALSE, frequencies = frq.table.3, mfw.min=2000, mfw.max=4000, corpus.lang ="French", distance.measure="wurzburg",
      display.on.screen=FALSE, analysis.type="BCT", write.png.file = TRUE, plot.custom.height = 6, plot.custom.width=6,  plot.font.size=6)


