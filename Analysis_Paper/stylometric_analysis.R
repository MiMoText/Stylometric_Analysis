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

# path and filename for distance tables
output.filename = sprintf("results/distance_table_%sMFW_wurzburg.csv", mfws)

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


# Save distance table
write.csv(result_dendo$distance.table, sprintf("%s.csv", output.filename), row.names = TRUE)


# Step 2: General Imposters Method
## taking 2000 MFWs
imposters2000 = imposters(reference.set = frq.table.all[-c(1), 1:2000], test = frq.table.all[1,1:2000], distance="wurzburg")
imposters2000

df = data.frame(as.list(imposters2000))

counter <- 0

while (counter <= 10 ) {
  new_imp = imposters(reference.set = frq.table.all[-c(1), 1:2000], test = frq.table.all[1,1:2000], distance="wurzburg")
  df <- rbind(df, new_imp)
  counter <- counter + 1
  
} 

#=> Mirabeau 	 0.29
#Nerciat 	 0.06
#PigaultLebrun 	 0.78
#Retif 	 0.65

optim_imposters2000_w = imposters.optimize(frq.table.all[, 1:2000], distance="wurzburg")
optim_imposters2000_w

# results [1] 0.29 0.68


##########################################################################################



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

