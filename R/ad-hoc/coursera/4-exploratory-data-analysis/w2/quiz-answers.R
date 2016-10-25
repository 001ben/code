library(lattice)

cat('q1 answer\n')
cat(class(xyplot(mpg ~ hp, data=mtcars)), '\n\n')

cat('q2 answer\n')
cat('a set of 3 panels showing the relationship between weight and time for each diet\n\n')

cat('q3 answer\n')
cat('panel.abline()\n\n')

cat('q4 answer\n')
cat('the object p has not been printed yet\n\n')

cat('q5 answer\n')
cat('trellis.par.set\n\n')

cat('q6 answer\n')
cat('ggplot2 is an implementation of the Grammar of Graphics by Leland wilkinson\n\n')

# library(datasets)
# library(ggplot2)
# data(airquality)

cat('q7 answer\n')
# airquality = transform(airquality, Month = factor(Month))
# qplot(Wind, Ozone, data = airquality, facets = . ~ Month)
cat('airquality = transform(airquality, Month = factor(Month))\n')
cat('qplot(Wind, Ozone, data = airquality, facets = . ~ Month)\n\n')

cat('q8 answer\n')
cat('I think it\'s a plotting object like point, line or other shape, check this one...\n\n')

cat('q9 answer\n')
cat('ggplot does not know what type of layer to add to the plot\n\n')

cat('q10 answer\n')
cat('Use geom_smooth() to add a smoother\n')
# data(movies)
# library(ggplot2movies)
# qplot(votes, rating, data=movies) + geom_smooth()
