#!/usr/local/bin/Rscript
library(MASS)
library(tree)
set.seed(1)

train <- sample(1:nrow(Boston), nrow(Boston)/2)
tree.boston <- tree(medv~., data=Boston, subset=train)

#plot(tree.boston)
#text(tree.boston, pretty=0)

cv.boston <- cv.tree(tree.boston)
#plot(cv.boston$size, cv.boston$dev, type="b")

minIdxs <- cv.boston$dev == min(cv.boston$dev)
minVals <- cv.boston$size[minIdxs]
cat(sprintf('\nmax tree size is: %s\n', max(cv.boston$size)))
cat(sprintf('best tree size is: %s\n', minVals))

prune.boston <- prune.tree(tree.boston, best=minVals[[1]])

yhat <- predict(prune.boston, Boston[-train,])
boston.test=Boston[-train, "medv"]
#plot(yhat, boston.test) # show predicted against actual median value

mse <- mean((yhat-boston.test)^2)
cat(sprintf('tree - mean error squared: %s\n', mse))
cat(sprintf('tree - average error:  $%.2f\n\n', sqrt(mse) * 1000))

