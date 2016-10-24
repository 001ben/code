library(ggplot2)
attach(mtcars)

cyl.f <- as.factor(mtcars$cyl)

# basic scatterplot with color
qplot(hp, mpg, color=cyl.f)

# basic box plot with colors
qplot(cyl.f, mpg, color=as.factor(gear), geom='boxplot')

# basic histogram with facets
qplot(mpg, facets= cyl.f ~ .)
