library(ggplot2)
attach(mtcars)

cyl.f <- as.factor(mtcars$cyl)

# basic histogram with facets
qplot(mpg, facets= cyl.f ~ .)
