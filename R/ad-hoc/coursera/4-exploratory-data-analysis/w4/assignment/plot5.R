library(ggplot2)
library(plyr)
library(dplyr)
library(gridExtra)

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
SCC <- tbl_df(readRDS(scc.filename))

# plotting code
motor.vehicles <- filter(SCC, SCC.Level.One == 'Mobile Sources' ) %>%
  mutate(SCC=as.character(SCC))

baltimore.motor.vehicles <- filter(NEI, fips == '24510') %>%
  inner_join(motor.vehicles, by='SCC')

motor.sums <- ddply(baltimore.motor.vehicles, c('year', 'EI.Sector'), summarise, total.pm25=sum(Emissions))
overall.sum <- ddply(baltimore.motor.vehicles, 'year', summarise, total.pm25=sum(Emissions))

year.sector <- ggplot(motor.sums, aes(year, total.pm25, colour=EI.Sector)) + 
  labs(title='Total pm25 emissions from motor vehicles in baltimore by sector') +
  geom_line()

year.only <- ggplot(overall.sum, aes(year, total.pm25)) +
  labs(title='Total pm25 emissions from motor vehicles in baltimore overall') +
  geom_line()

png('plot5.png', width=720, height=960)

grid.arrange(year.sector, year.only, nrow=2)

dev.off()
