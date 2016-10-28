with(cars, plot(speed, dist, xlab='speed (mph)', ylab='stopping distance (ft)'))

# add a title
title(main='Stopping distance for different speeds')
lines(lowess(cars))
with(cars, text(mean(speed), mean(dist), 'The average speed', col='red', pos=3))
with(cars, points(mean(speed), mean(dist), col='red'))
