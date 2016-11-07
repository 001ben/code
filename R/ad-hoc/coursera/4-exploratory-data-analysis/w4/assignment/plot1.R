files.url <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip'

nei.filename <- 'summarySCC_PM25.rds'
scc.filename <- 'Source_Classification_Code.rds'

## This first line will likely take a few seconds. Be patient!
if (!file.exists(nei.filename) | !file.exists(scc.filename)) {
  cat('downloading files...\n')
  download.file(files.url, 'assign-data.zip', method='curl')
  unzip('assign-data.zip')
}

NEI <- readRDS(nei.filename)

# turn off scientific notation
options(scipen=6)

# calculate totals
total.pm25 <- aggregate(NEI$Emissions, by=list(year=NEI$year), FUN=sum)

# transpose and assign names to data for the bar plot
barplot.data <- t(total.pm25$x)
colnames(barplot.data) <- total.pm25$year

png('plot1.png', width=480, height=480)

barplot(barplot.data, main='Total pm25 emissions per year', col='blue')

dev.off()
