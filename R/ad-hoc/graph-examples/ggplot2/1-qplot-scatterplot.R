library(ggplot2)
attach(mtcars)

cyl.f <- as.factor(mtcars$cyl)

# basic scatterplot with color
qplot(hp, mpg, color=cyl.f)
