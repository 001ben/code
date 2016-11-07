library(ggplot2)
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

# Determing Coal Combustion sources based on the short name
pm <- filter(SCC, grepl('\\bcoal\\b.*comb|comb.*\\bcoal\\b', Short.Name, ignore.case=T)) %>% 
  mutate(SCC=as.character(SCC)) %>% # convert to char type for the join
  inner_join(NEI, by='SCC') %>%
  filter(Emissions != 0) %>%           # filtering out 0 values for the log operation
  mutate(log.pm25=log(Emissions))

png('plot4.png', width=960, height=480)

qplot(log.pm25, fill=EI.Sector, data=pm, facets=. ~ year, bins=40, main='Log of pm25 emissions from coal combustion sources')

dev.off()
