# graph 2 - global active power per day
suppressMessages(library(dplyr))

source('read-assignment-data.R')

png('plot4.png')

par(mfrow=c(2,2))
# top left graph
with(house.power, plot(datetime, Global_active_power, type='l', xlab=NA, ylab='Global Active Power')) 
# top right graph
with(house.power, plot(datetime, Voltage, type='l')) 

# bottom left graph
with(house.power, plot(datetime, Sub_metering_1, type='n', ylab='Energy sub metering', xlab=NA, xaxt='n'))
with(house.power, lines(datetime, Sub_metering_1, type='l'))
with(house.power, lines(datetime, Sub_metering_2, type='l', col='red'))
with(house.power, lines(datetime, Sub_metering_3, type='l', col='blue'))

legend('topright', col=c('black', 'red', 'blue'), legend=c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), lty=1)

# bottom right graph
with(house.power, plot(datetime, Global_reactive_power, type='l')) 

invisible(dev.off())
cat('success! graph saved to plot4.png\n')
