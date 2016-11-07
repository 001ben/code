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
SCC <- tbl_df(readRDS(scc.filename))

# plotting code
motor.vehicles <- filter(SCC, SCC.Level.One == 'Mobile Sources') %>%
  mutate(SCC=as.character(SCC))

motor.vehicles <- filter(NEI, fips %in% c('24510', '06037')) %>%
  mutate(state=factor(fips, levels=c('24510', '06037'), labels=c('Baltimore City', 'Los Angeles County'))) %>%
  inner_join(motor.vehicles, by='SCC')

motor.aggregate <- ddply(motor.vehicles, c('year', 'state'), summarise, total.pm25=sum(Emissions))

## histogram
# ggplot(baltimore.motor.vehicles, aes(log.pm25, colour=EI.Sector)) + 
#   labs(title='mean log of pm25 from motor vehicles in baltimore') +
#   facet_grid(. ~ year) +
#   geom_histogram(bins=30) +
#   geom_rug()

png('plot6.png', width=720, height=720)

ggplot(motor.aggregate, aes(year, total.pm25, colour=state)) + 
  labs(title='Total pm25 emissions') +
  geom_line()

dev.off()
