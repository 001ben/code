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
NEI <- readRDS(nei.filename)
SCC <- readRDS(scc.filename)

# plotting code

