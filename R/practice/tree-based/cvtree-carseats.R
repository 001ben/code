#!/usr/local/bin/Rscript
source('./tree-carseat-sale-prediction.R')

set.seed(3)
cv.carseats <- cv.tree(tree.carseats, FUN=prune.misclass)

old.par <- par(no.readonly=T)
par(mfrow=c(1,2))
plot(cv.carseats$size, cv.carseats$dev, type="b")
text(x=cv.carseats$size, y=cv.carseats$dev, labels=cv.carseats$size, pos=3)
plot(cv.carseats$k, cv.carseats$dev, type="b")
text(x=cv.carseats$k, y=cv.carseats$dev, labels=cv.carseats$size, pos=3)

minIdxs <- cv.carseats$dev == min(cv.carseats$dev)
minVals <- cv.carseats$size[minIdxs]
cat(sprintf('\nbest tree size is: %s\n', minVals))

pruned.carseats <- prune.misclass(tree.carseats, best=minVals[[1]])
pruned.predictions <- predict(pruned.carseats, modified.carseats.test, type="class")
cat(sprintf('pruned prediction accuracy: %s%%\n', (sum(pruned.predictions == High.test) / (n - train.size)) * 100))

#par(mfrow=c(1,2))
#plot(tree.carseats)
#title('original tree')
#text(tree.carseats, pretty=0)

#plot(pruned.carseats)
#title('pruned tree')
#text(pruned.carseats, pretty=0)

