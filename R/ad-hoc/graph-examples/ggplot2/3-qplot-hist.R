library(ggplot2)
attach(mtcars)

cyl.f <- as.factor(mtcars$cyl)

# basic histogram with facets
qplot(mpg, fill=as.factor(gear), facets= cyl.f ~ ., main='Frequency of Miles Per Galon')
