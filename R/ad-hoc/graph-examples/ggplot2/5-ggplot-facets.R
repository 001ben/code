library(ggplot2)

g <- ggplot(mtcars, aes(hp, mpg))
g + facet_grid(cyl ~ .) + geom_smooth(method='lm') + geom_point(aes(color=as.factor(gear))) + labs(x='Horsepower', y='Miles per Gallon', title='I like ggplot (broken down by cylinders)') 
