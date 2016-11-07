# reading data 
files.url <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip'

nei.filename <- 'summarySCC_PM25.rds'
scc.filename <- 'Source_Classification_Code.rds'

if (!file.exists(nei.filename) | !file.exists(scc.filename)) {
  cat('downloading files...\n')
  download.file(files.url, 'assign-data.zip', method='curl')
  unzip('assign-data.zip')
}

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS(nei.filename)
SCC <- readRDS(scc.filename)

# plotting code
pm0 <- subset(NEI, year==1999 & fips=='24510')
pm1 <- subset(NEI, year==2008 & fips=='24510')

plot(rep(1999, nrow(pm0) + nrow(pm1)), log(c(pm0$Emissions, pm1$Emissions)), type='n', xlim=range(1998:2008), 
     ylab='log of emissions', xlab='year')
points(rep(1999, nrow(pm0)), log(pm0$Emissions))
points(rep(2008, nrow(pm1)), log(pm1$Emissions))
