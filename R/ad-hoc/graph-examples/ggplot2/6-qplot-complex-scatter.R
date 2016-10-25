library(ggplot2)

qplot(carat, price, data=diamonds, color=cut, facets=.~cut) + geom_smooth(method='lm')
