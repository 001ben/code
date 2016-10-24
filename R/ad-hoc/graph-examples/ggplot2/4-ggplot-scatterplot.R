library(ggplot2)

cyl.f <- as.factor(mtcars$cyl)

g <- ggplot(mtcars, aes(hp, mpg))
g + geom_point() + geom_smooth(method='lm', se=F) + facet_grid(. ~ gear)
