suppressMessages(library(dplyr))

# download and read the data
url <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
zip.filename <- 'power-consumption.zip'
if (!file.exists(zip.filename)) {
  download.file(url, zip.filename, method='curl')
}

filename <- 'household_power_consumption.txt' 

if (!file.exists(filename)) {
  unzip(zip.filename)
}

# Keep all rows between 2007-2-1 00:00:00 and 2007-2-3 00:00:00
house.power <- 
  tbl_df(read.table(filename, sep=';', 
                    header = T, na.strings='?',
                    colClasses = c(rep('character',2), rep('numeric', 7)))) %>%
  mutate(datetime=paste(Date, Time)) %>%
  mutate(datetime=as.POSIXct(strptime(datetime, format='%d/%m/%Y %H:%M:%S'))) %>%
  select(-c(Date, Time)) %>% 
  filter(datetime > '2007-2-1' & datetime < '2007-2-3')
