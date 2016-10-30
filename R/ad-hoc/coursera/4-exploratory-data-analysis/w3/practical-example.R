source('../../../common/plclust-color.R')

file.url <- 'https://github.com/DataScienceSpecialization/courses/raw/master/04_ExploratoryAnalysis/clusteringExample/data/samsungData.rda'
filename <- 'samsung-data.rda'

if(!file.exists(filename)) {
  download.file(file.url, destfile = filename)
} 

load(filename)

samsungData <- transform(samsungData, activity = factor(activity))
ssd1 <- subset(samsungData, subject==1)

body.acc.mean.cols <- 1:3
d <- dist(ssd1[, body.acc.mean.cols])
clust <- hclust(d)
plclust_in_colour(clust, main = 'body acceleration mean', lab.col = unclass(ssd1$activity))
cat('We can see this doesn\'t clearly divide the activities\n')
cat('press any key to continue...\n')
invisible(readline())

body.acc.max.cols <- 10:12
d <- dist(ssd1[, body.acc.max.cols])
clust <- hclust(d)
plclust_in_colour(clust, main='body acceleration max', lab.col=unclass(ssd1$activity))
cat('We can see clustering on the max acceleration gives a much clearer separation of activities\n')
cat('press any key to continue...\n')
invisible(readline())
