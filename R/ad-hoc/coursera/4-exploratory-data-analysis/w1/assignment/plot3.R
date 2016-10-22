# graph 2 - global active power per day
suppressMessages(library(dplyr))

source('read-assignment-data.R')

png('plot3.png')

with(house.power, plot(datetime, Sub_metering_1, type='n', ylab='Energy sub metering', xlab=NA, xaxt='n'))
with(house.power, lines(datetime, Sub_metering_1, type='l'))
with(house.power, lines(datetime, Sub_metering_2, type='l', col='red'))
with(house.power, lines(datetime, Sub_metering_3, type='l', col='blue'))

axis.POSIXct(1, at=as.POSIXct(c('2007-02-01', '2007-02-03')), format='%a')
axis.POSIXct(1, at=as.POSIXct('2007-02-02'), format='%a', font=2)

legend('topright', col=c('black', 'red', 'blue'), legend=c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), lty=1)

invisible(dev.off())
cat('success! graph saved to plot3.png\n')
