#!/usr/local/bin/Rscript
library(tree)
library(ISLR)

High <- ifelse(Carseats$Sales<=8, 'No', 'Yes')
modified.carseats <- data.frame(Carseats, High)

# Separate cross validation set
set.seed(2)
n <- nrow(modified.carseats)
train.size <- n * 0.5
train <- sample(1:n, train.size)
modified.carseats.test <- modified.carseats[-train,]
High.test <- High[-train]

# Build decision tree
tree.carseats <- tree(High ~ . - Sales, modified.carseats, subset=train)

# Test decision tree
tree.pred <- predict(tree.carseats, modified.carseats.test, type="class")
cat('prediction results:\n')
print(table(tree.pred, High.test))
cat(sprintf('\nprediction accuracy: %s%%\n', (sum(tree.pred == High.test) / (n - train.size)) * 100))
