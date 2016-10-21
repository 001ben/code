library(lattice)

unique.cyl <- length(unique(mtcars$cyl))
xyplot(hp ~ wt | factor(cyl), data=mtcars, layout=c(unique.cyl, 1), main='HP to wt for different cylinder cars')
