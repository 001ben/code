# import libraries
library(ggplot2)
library(plyr)
library(dplyr)

# reading data in
files.url <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip'

nei.filename <- 'summarySCC_PM25.rds'
scc.filename <- 'Source_Classification_Code.rds'

if (!file.exists(nei.filename) | !file.exists(scc.filename)) {
  cat('downloading files...\n')
  download.file(files.url, 'assign-data.zip', method='curl')
  unzip('assign-data.zip')
}

# This line will likely take a few seconds. Be patient!
NEI <- tbl_df(readRDS(nei.filename))

# plotting code
total.pm25 <- filter(NEI, fips=='24510') %>%
  ddply(.(year, type), summarise, pm25=sum(Emissions))

png('plot3.png', width=480, height=480)

ggplot(total.pm25, aes(year, pm25, colour=type), main='average pm25 emissions') + 
  labs(title='Total pm25 emissions in baltimore by measurement type') + 
  geom_line() 

dev.off()
