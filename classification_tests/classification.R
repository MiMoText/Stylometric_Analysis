# Script for classification in several steps

library(stylo)
library(tools)

# load all texts, make freq list and table of frequencies from the corpus "more than 3 samples
# so that the frequency list is built based on all novels
# you also could load a frequency table if one exists
set.all <- load.corpus.and.parse(corpus.dir="C:/Users/Administrator/Desktop/Stylo_GitHub/Stylometry_MiMoText_roman18/corpora/more_than_3_samples", corpus.lang="French")
freq.list.all <- make.frequency.list(set.all, head=3000)
frq.table.all <- make.table.of.frequencies(corpus = set.all, features=freq.list.all)


# split in training and test based on the filenames of the files within the train and the test set folder

test.list <- file_path_sans_ext(list.files(path="test_strat"))
train.list <- file_path_sans_ext(list.files(path="training_Strat"))
print(test.list)

# extract frequencies for train set and test set
test.set <- frq.table.all[c(test.list), 1:3000]
train.set <- frq.table.all[c(train.list), 1:3000]


print(dim(train.set))
print(train.list)


########### using perform => preliminary test

results_svm <- perform.svm(train.set, test.set, no.of.candidates = 10)
summary(results_svm)
performance.measures(results_svm)
results_svm$confusion_matrix
results_svm$y
results_svm$scores
results_svm$ranking


#### perform a  cross validation with different classifier methods and plot the results
# parallel to https://computationalstylistics.github.io/blog/performance_measures/

mfw_test = seq(from = 100, to=3000, by = 50)
f1_all = c()
acc_all= c()

classifier = "naivebayes" # , nsc, "svm", delta, knn, naivebayes

for (m in mfw_test){
  curr_set = train.set[, 1:m]
  curr_res = crossv(training.set = curr_set,
                          cv.folds=50,
                    classification.method=classifier)
  perf = performance.measures(curr_res)
  
  get_f1 = perf$avg.f
  acc = perf$accuracy
  
  f1_all = c(f1_all, get_f1)
  acc_all = c(acc_all, acc)

}

summary(results_cross_V)
results_cross_V$confusion_matrix
results_cross_V$misclassified

performance.measures(results_cross_V)

# plot the results
plot(f1_all ~ mfw_test,
     main = "Performace measure: a comparison: Naive Bayes",
     ylab = "accuracy and F1 score",
     xlab = "most freq words",
     ylim = c(0.1, 1),
     col = "blue")

points(acc_all ~ mfw_test, col="red")
legend("bottomright",
       legend=c("Accuracy", "F1 score"),
       col = c("red", "blue"),
       text.col=c("red", "blue"),
       pch=1,
       bty="n")


### as the delta classifier gave the best results:
# search for best parameters in classifier DELTA using different distance measures and different MFWs
# save the results in csv files

supported.measures = c("dist.euclidean", "dist.manhattan", "dist.canberra", "dist.delta", 
                       "dist.eder", "dist.argamon", "dist.simple", "dist.cosine", "dist.wurzburg",
                       "dist.entropy", "dist.minmax")



mfw.list <- seq(from = 500, to=3000, by = 100) 

for (s in supported.measures){
  Data_Frame <- data.frame(Cull=c(0), MFW=c(0), Acc=c(0), Prec=c(0), Recall=c(0), FScore=c(0))
  for (y in mfw.list){
    
    results <- classify(training.frequencies = train.set, test.frequencies = test.set,
                        corpus.lang = "French",
                        mfw.min = y, mfw.max=y, mfw.incr = 100,
                        classification.method = "delta", 
                        distance.measure=s,
                        cv.folds = 50 , gui=FALSE, 
                        culling.min = 0, culling.max = 0)
    print(results$overall.success.rate)
    #print(results$success.rate)
    #print(performance.measures(results)$accuracy)
    Data_Frame <- rbind(Data_Frame, c(0, y , performance.measures(results)$accuracy, performance.measures(results)$avg.precision,performance.measures(results)$avg.recall, performance.measures(results)$avg.f ))
    
  }
  write.csv(Data_Frame, sprintf("classification_delta_output/results_strat_split_w_NM_delta_%s_cull0.csv", s), row.names = TRUE)
}

