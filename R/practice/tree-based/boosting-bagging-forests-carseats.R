#!/usr/local/bin/Rscript
source('./regression-tree-carseats.R')
invisible(library(randomForest))
set.seed(1)
bag.boston <- randomForest(medv ~ ., data=Boston, subset=train, mtry=ncol(Boston) - 1, importance=T)

# validate model
yhat.bag <- predict(bag.boston, newdata=Boston[-train,])
#plot(yhat.bag, boston.test) # Show predicted against actual median value
bag.mse <- mean((yhat.bag - boston.test) ^ 2)
cat(sprintf('bagging - mean error squared: %s\n', bag.mse))
cat(sprintf('bagging - average error: $%.2f\n\n', sqrt(bag.mse) * 1000))

rf.boston <- randomForest(medv ~ ., data=Boston, subset=train, importance=T)
yhat.rf <- predict(rf.boston, newdata=Boston[-train,])
rf.mse <- mean((yhat.rf - boston.test) ^ 2)

cat(sprintf('random forest - mean error squared: %s\n', rf.mse))
cat(sprintf('random forest - average error: $%.2f\n', sqrt(rf.mse) * 1000))

cat('importance of variables:\n')
imp <- importance(rf.boston)
imp <- imp[order(imp[,"%IncMSE"], decreasing=T),]
print(imp)

#varImpPlot(rf.boston) # See a plot of the importances
library(gbm)
set.seed(1)
boost.boston <- gbm(medv ~ ., data=Boston[train,], distribution="gaussian", n.trees=5000, interaction.depth=4)
summary(boost.boston)

yhat.boost <- predict(boost.boston, newdata=Boston[-train,], n.trees=5000)
boost.mse <- mean((yhat.boost - boston.test) ^ 2)
cat(sprintf('boosted trees - mean error squared: %s\n', boost.mse))
cat(sprintf('boosted trees - average error: $%.2f\n', sqrt(boost.mse) * 1000))
