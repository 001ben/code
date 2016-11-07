# reading data 
files.url <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip'

nei.filename <- 'summarySCC_PM25.rds'
scc.filename <- 'Source_Classification_Code.rds'

if (!file.exists(nei.filename) | !file.exists(scc.filename)) {
  cat('downloading files...\n')
  download.file(files.url, 'assign-data.zip', method='curl')
  unzip('assign-data.zip')
}

# This line will likely take a few seconds. Be patient!
NEI <- readRDS(nei.filename)

# plotting code

pm.sub <- subset(NEI, fips=='24510')
emission.changes <- aggregate(pm.sub$Emissions, by=list(year=pm.sub$year), FUN=sum)

# calculate totals
barplot.data <- t(emission.changes$x)
colnames(barplot.data) <- emission.changes$year

png('plot2.png', width=480, height=480)

barplot(barplot.data, main='Changes in Baltimore total pm25', ylab='Total pm25', xlab='Year', col='green')

dev.off()
