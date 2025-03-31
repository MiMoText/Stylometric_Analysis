# load libraries

library(stylo)
library(tools)

corpus.directory = "corpora/narrativeForm"

  # corpus_more_than_3_samples_Enfant_Mirabeau


# Step 1: Create Dendrogram, and BCT

## load texts, make freq list and table of frequencies with sub corpus

set.3 <- load.corpus.and.parse(corpus.dir=corpus.directory, corpus.lang="French")
freq.list.3 <- make.frequency.list(set.3, head=3500)
frq.table.3 <- make.table.of.frequencies(corpus = set.3, features=freq.list.3)

freq.list.3
frq.table.3


# Dendrogram
result_dendo <- stylo(gui=FALSE, frequencies = frq.table.3, mfw.min=2000, mfw.max=2000, corpus.lang ="French", distance.measure="wurzburg",
                      display.on.screen=FALSE, write.png.file = TRUE, plot.custom.height = 9, plot.font.size=6)

# BootStrap Consensus Tree
result_bct <- stylo(gui=FALSE, frequencies = frq.table.3, mfw.min=2000, mfw.max=35000, corpus.lang ="French", distance.measure="wurzburg",
                    display.on.screen=FALSE, analysis.type="BCT", write.png.file = TRUE, plot.custom.height = 8, plot.font.size=6)


write.csv(result_dendo$distance.table, sprintf("distance_table_2000MFW_wurzburg_narrForm.csv"), row.names = TRUE)


# Step 2: Imposters Method

# load all texts, make freq list and table of frequencies
set.all <- load.corpus.and.parse(corpus.dir="corpora/corpus_more_than_3_samples_Enfant_Mirabeau", corpus.lang="French")
freq.list.all <- make.frequency.list(set.all, head=2000)
frq.table.all <- make.table.of.frequencies(corpus = set.all, features=freq.list.all)


#### MFW = 500
grep("Anonym_Enfant", rownames(frq.table.all))

imposters = imposters(reference.set = frq.table.all[-c(1), 1:500], test = frq.table.all[1,1:500], distance="wurzburg")
imposters
## NEU
#Mirabeau 	 0.21
#Nerciat 	 0.23
#PigaultLebrun 	 0.99
#Retif 	 0.38

# optimizing decision scores:
# based on alogrithm by Kesetmont et al. based on c@1 measure
# only authors with >1 samples are used (Anonym is deleted)
optim_imposters = imposters.optimize(frq.table.all[, 1:500])
optim_imposters
# output = parameter p1 and p2

optim_imposters_w = imposters.optimize(frq.table.all[, 1:500], distance="wurzburg")
optim_imposters_w

# => results [1] 0.40 0.58

## taking 2000 MFWs
imposters2000 = imposters(reference.set = frq.table.all[-c(1), 1:2000], test = frq.table.all[1,1:2000], distance="wurzburg")
imposters2000

#=> Mirabeau 	 0.29
#Nerciat 	 0.06
#PigaultLebrun 	 0.78
#Retif 	 0.65

optim_imposters2000_w = imposters.optimize(frq.table.all[, 1:2000], distance="wurzburg")
optim_imposters2000_w

# results [1] 0.29 0.68


##########################################################################################
# Test if Enfant was written by PL:
text_to_be_tested = frq.table.all[1,] # Anonym_Enfant
## Check PL
grep("PigaultLebrun_Adele", rownames(frq.table.all))
my_candidate = frq.table.all[71:74,]
my_imposters = frq.table.all[-c(1, 71:74),]
imp_refs = imposters(reference.set = my_imposters, test = text_to_be_tested, candidate.set = my_candidate, features=0.5)
imp_refs

## Check Mirabeau
grep("Mirabeau_Conversion", rownames(frq.table.all))
mirabeau = frq.table.all[65:66,]
mirabeau_imps = frq.table.all[-c(1, 65:66),]
mirabeau_refs = imposters(reference.set = mirabeau_imps, test = text_to_be_tested, candidate.set = mirabeau, features=0.5)
mirabeau_refs

