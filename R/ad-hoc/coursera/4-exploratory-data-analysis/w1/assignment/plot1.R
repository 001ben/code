# graph 1 - global active power histogram
suppressMessages(library(dplyr))
source('read-assignment-data.R')

png('plot1.png')

with(house.power, hist(Global_active_power, 
                       col='red', 
                       xlab='Global Active Power (kilowatts)',
                       main='Global Active Power'))

invisible(dev.off())
cat('success! graph saved to plot1.png\n')
