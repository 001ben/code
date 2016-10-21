# par rows
par(mfrow=c(2, 1), mar=c(4,4,2,1))
hist(subset(iris, Species=='setosa')$Sepal.Width, col='blue')
hist(subset(iris, Species!='setosa')$Sepal.Width, col='red')

# multi-boxplot
boxplot(Sepal.Width ~ Species, data=iris, col='red')
