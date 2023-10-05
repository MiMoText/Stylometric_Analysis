data <- read.csv("xml-tei_full_metadata.tsv", header=TRUE, sep="\t")

library(splitstackshape)

out <- stratified(data, c("au.gender", "form", "name"), size=0.7, bothSets = TRUE)
head(out)