library(ggplot2)
attach(mtcars)

cyl.f <- as.factor(mtcars$cyl)

# basic box plot with colors
qplot(cyl.f, mpg, color=as.factor(gear), geom='boxplot')
