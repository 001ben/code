if(!file.exists("./data")){dir.create("./data")}
fileUrl1 <- "https://dl.dropboxusercontent.com/u/7710864/data/reviews-apr29.csv"
fileUrl2 <- "https://dl.dropboxusercontent.com/u/7710864/data/solutions-apr29.csv"
destfile1 <- "./data/reviews.csv"
destfile2 <- "./data/solutions.csv"
if(!file.exists(destfile1)){download.file(fileUrl1, destfile=destfile1,method="curl")}
if(!file.exists(destfile2)){download.file(fileUrl2, destfile=destfile2,method="curl")}
reviews <- read.csv(destfile1); solutions <- read.csv(destfile2)
