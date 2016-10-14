suppressMessages(library(dplyr))
suppressMessages(library(quantmod))
suppressMessages(library(lubridate))

z <- Sys.setlocale('LC_ALL', 'C')
options('getSymbols.warning4.0'=F)

url <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv'
filename <- 'q1.csv'
if (!file.exists(filename)) {
  download.file(url, filename, method='curl')
}

url2 <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv'
filename2 <- 'q1-gdp.csv'
if (!file.exists(filename2)) {
  download.file(url2, filename2, method='curl')
}

url3 <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv'
filename3 <- 'q1-edu.csv'
if (!file.exists(filename3)) {
  download.file(url3, filename3, method='curl')
}

#q1 answer
house <- read.csv(filename, header=T)
splitnames <- strsplit(names(house), 'wgtp')
cat('q1 answer:', toString(splitnames[123]), '\n\n')

#q2 answer
gdp <- read.table(filename2, sep=',', skip=3, header=T, quote="\"", nrows=191)
gdp <- gdp[2:nrow(gdp),colSums(is.na(gdp)) < nrow(gdp)]
gdp <- rename(gdp, us.dollars=US.dollars.)
avg.gdp <- mean(as.integer(gsub(',', '', gdp$us.dollars, fixed=T)))
cat('q2 answer:', avg.gdp, '\n\n')

#q3 answer
gdp <- rename(gdp, countryCode=X, countryNames=Economy)

cat('q3 answers:\n')
cat('\tq3 regex: grep("^United",countryNames)\n')
cat('\tq3 count:', length(grep('^United', gdp$countryNames)), '\n\n')

#q4 answer
edu <- read.csv(filename3)
edu %>% rename(countryCode=CountryCode) %>% filter(grepl('fiscal year end: June', Special.Notes, ignore.case=T)) %>% summarise(count(.)) -> q4.summary
cat('q4 answer:', q4.summary[[1, 1]], '\n\n')

#q5 answer
amzn <- getSymbols('AMZN', auto.assign=F)
sampleTimes = ymd(index(amzn))
vals.2012 <- sampleTimes[year(sampleTimes) == 2012]
vals.monday <- vals.2012[wday(vals.2012) == 2]
cat('q5 answers:\n')
cat('\tvalues in 2012:', length(vals.2012), '\n')
cat('\tvalues in 2012 on monday:', length(vals.monday), '\n\n')
