## authorship verification for Enfant du bordel, PigaultLebrun
## see https://computationalstylistics.github.io/blog/imposters/

# General Imposters Method in stylo
# using frequency matrix
# contrasts text in question against some text by possible candidates
# and a selection of imposters
# score > 0.5 => successful
# some scores are considered suspicious: problems in making decisions
# => imposters.optimize() (grid search)
library(stylo)

# load all texts, make freq list and table of frequencies
set.all <- load.corpus.and.parse(corpus.dir="corpora/imposter", corpus.lang="French")
freq.list.all <- make.frequency.list(set.all, head=2000)
frq.table.all <- make.table.of.frequencies(corpus = set.all, features=freq.list.all)


#### MFW = 500
grep("Anonym_Enfant", rownames(frq.table.all))

imposters = imposters(reference.set = frq.table.all[-c(1), 1:500], test = frq.table.all[1,1:500], distance="wurzburg")

# Retif af 0.42 => not sure

# optimizing decision scores:
# based on alogrithm by Kesetmont et al. based on c@1 measure
# only authors with >1 samples are used (Anonym is deleted)
optim_imposters = imposters.optimize(frq.table.all[, 1:500])
optim_imposters
# output = parameter p1 and p2
# distance delta:  => 0.35 0.64

# say how to interpret result
# values < 0.35 and > 0.64 can ne translated to "no" and "yes" 

optim_imposters_w = imposters.optimize(frq.table.all[, 1:500], distance="wurzburg")
optim_imposters_w

# => result: 0.28 0.67

## taking 2000 MFWs
imposters2000 = imposters(reference.set = frq.table.all[-c(1), 1:2000], test = frq.table.all[1,1:2000], distance="wurzburg")
imposters2000
optim_imposters2000_w = imposters.optimize(frq.table.all[, 1:2000], distance="wurzburg")
optim_imposters2000_w

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
##########################################################################################

### test imposter method for Etourdi

grep("XXX_Etourdi", rownames(frq.table.all))
rownames(frq.table.all)
imposter_Etourdi = imposters(reference.set = frq.table.all[-c(1, 113), 1:500], test = frq.table.all[113,1:500], distance="wurzburg")
imposter_Etourdi

# check Mirabeau

mirabeau = frq.table.all[65:66,]
mirabeau_imps = frq.table.all[-c(1, 65:66, 113),]
mirabeau_refs = imposters(reference.set = mirabeau_imps, test = frq.table.all[113,], candidate.set = mirabeau, features=0.5)
mirabeau_refs

# Check Nerciat:
grep("Nerciat_Aphrodites", rownames(frq.table.all))
nerciat = frq.table.all[67:70,]
nerciat_imps = frq.table.all[-c(1, 67:70, 113),]
nerciat_refs = imposters(reference.set = nerciat_imps, test = frq.table.all[113,], candidate.set = nerciat, features=0.5)
nerciat_refs


### both:
nerciat_mira = frq.table.all[65:70,]
nerciat_mira_imps = frq.table.all[-c(1, 65:70, 113),]
nerciat_mira_refs = imposters(reference.set = nerciat_mira_imps, test = frq.table.all[113,], candidate.set = nerciat_mira, features=0.5)
nerciat_mira_refs