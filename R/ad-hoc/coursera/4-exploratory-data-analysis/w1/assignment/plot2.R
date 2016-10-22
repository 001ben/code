# graph 2 - global active power per day
suppressMessages(library(dplyr))

source('read-assignment-data.R')

png('plot2.png')

with(house.power, plot(datetime, Global_active_power, type='l', lty=1, 
                       ylab='Global Active Power (kilowatts)', xlab=NA, xaxt='n'))

axis.POSIXct(1, at=as.POSIXct(c('2007-02-01', '2007-02-03')), format='%a')
axis.POSIXct(1, at=as.POSIXct('2007-02-02'), format='%a', font=2)

invisible(dev.off())
cat('success! graph saved to plot2.png\n')
