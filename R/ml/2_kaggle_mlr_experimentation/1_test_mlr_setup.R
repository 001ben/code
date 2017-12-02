library(mlr)

data(mtcars)

cluster_task <- makeClusterTask(data = mtcars)
kmeans_lrn <- makeLearner('cluster.kmeans', centers = 2)
model <- train(kmeans_lrn, cluster_task)

getTaskFeatureNames(cluster_task)
getFeatureImportance(model)

plotLearnerPrediction(kmeans_lrn, task=cluster_task, features= c('disp', 'hp'))
