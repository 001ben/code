library(mlr)
library(dplyr)
library(magrittr)
library(purrr)

data(iris)

# Quickstart example ====

## 1) Define the task
## Specify the type of analysis (e.g. classification) and provide data and response variable
task <- makeClassifTask(id = 'iris_task', data = iris, target = "Species")
summary(getTaskData(task))

## 2) Define the learner
## Choose a specific algorithm (e.g. linear discriminant analysis)
lrn <- makeLearner("classif.lda")
lrn <- makeLearner("classif.randomForest")

n <- nrow(iris)
train.set <- sample(n, size = 2/3*n)
test.set <- setdiff(1:n, train.set)

## 3) Fit the model
## Train the learner on the task using a random subset of the data as training set
model <- train(lrn, task, subset = train.set)

## 4) Make predictions
## Predict values of the response variable for new observations by the trained model
## using the other part of the data as test set
pred <- predict(model, task = task, subset = test.set)

## 5) Evaluate the learner
## Calculate the mean misclassification error and accuracy
performance(pred, measures = list(mmce, acc))

# ===

# Survival example ====
data(lung, package = "survival")
help(lung)
summary(lung)
lung[,'status'] <- lung[,'status'] == 2 # Convert to logical
summary(lung)

# ===

# Multilabel classification ====
yeast <- getTaskData(yeast.task)
labels <- colnames(yeast)[1:14]
yeast_task <- makeMultilabelTask(id = "multi_yeast", data = yeast, target = labels)

# ===
