library(DAAG)

datafile(file="molclock1")
datafile(file="molclock2")

file.show('molclock1.txt')
molclock1 <- read.table('molclock1.txt', header=T)
molclock2 <- read.table('molclock2.txt', header=T)

