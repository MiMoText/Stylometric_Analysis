library(stylo)
library(tools)


# corpus:
# training: authors with more than 3 samples (training strat), Neufville de Montador and Mirabeau
# test: (test strat), and Anonym_Enfant, XXX_Etourdi

# load all texts, make freq list and table of frequencies
set.all <- load.corpus.and.parse(corpus.dir="C:/Users/Administrator/Desktop/Stylo_GitHub/Stylometry_MiMoText_roman18/corpora/more_than_3_samples", corpus.lang="French")
freq.list.all <- make.frequency.list(set.all, head=3000)
frq.table.all <- make.table.of.frequencies(corpus = set.all, features=freq.list.all)



# split in training and test 
test.list <- file_path_sans_ext(list.files(path="test_strat"))
train.list <- file_path_sans_ext(list.files(path="training_strat"))
print(test.list)

print(train.list)
test.set <- frq.table.all[c(test.list), 1:2800]
train.set <- frq.table.all[c(train.list), 1:2800]


result_delta = perform.delta(train.set, test.set, distance = "dist.wurzburg", no.of.candidates = 5) # default: delta

performance.measures(result_delta)

result_delta$confusion_matrix
result_delta$y
result_delta$scores
result_delta$ranking

table(result_delta$expected, result_delta$predicted)



### using classify()

results_delta_classl <- classify(training.frequencies = train.set, test.frequencies = test.set,
                    corpus.lang = "French",
                    mfw.min = 2800, mfw.max=2800, mfw.incr = 100,
                    classification.method = "delta", 
                    distance.measure="dist.wurzburg",
                    #cv.folds = 50 ,
                    gui=FALSE, 
                    culling.min = 0, culling.max = 0)
print(results_delta_classl$overall.success.rate)

performance.measures(results_delta_classl)