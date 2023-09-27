library(stylo)

# load all texts, make freq list and table of frequencies
set.all <- load.corpus.and.parse(corpus.dir="C:/Users/Administrator/Desktop/Stylo_GitHub/Stylometry_MiMoText_roman18/corpora/more_than_3_samples", corpus.lang="French")
freq.list.all <- make.frequency.list(set.all, head=3000)
frq.table.all <- make.table.of.frequencies(corpus = set.all, features=freq.list.all)


# split in training and test 
test.list <- file_path_sans_ext(list.files(path="test"))
train.list <- file_path_sans_ext(list.files(path="training"))
print(test.list)

test.set <- frq.table.all[c(test.list), 1:3000]
train.set <- frq.table.all[c(train.list), 1:3000]


print(dim(train.set))
### search for best parameters


Data_Frame <- data.frame(Cull=c(0), MFW=c(0), Acc=c(0), Prec=c(0), Recall=c(0), FScore=c(0))
Data_Frame

cull.list <- seq(from = 20, to = 80, by = 10)
mfw.list <- seq(from = 500, to=3000, by = 100)
for (x in cull.list){
  for (y in mfw.list){
    
    results <- classify(training.frequencies = train.set, test.frequencies = test.set,
                        mfw.min = y, mfw.max=y, mfw.incr = 100,
                        distance.measure="wurzburg",
                        classification.method = "svm", cv.folds = 20 , gui=FALSE, culling.min = x, culling.max = x)
    print(results$overall.success.rate)
    print(results$success.rate)
    print(performance.measures(results)$accuracy)
    Data_Frame <- rbind(Data_Frame, c(x, y , performance.measures(results)$accuracy, performance.measures(results)$avg.precision,performance.measures(results)$avg.recall, performance.measures(results)$avg.f ))
  }
}

write.csv(Data_Frame, "results_wurzburg_svm.csv", row.names = TRUE)
