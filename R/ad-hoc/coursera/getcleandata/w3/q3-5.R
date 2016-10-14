#q3 section
suppressMessages(library(dplyr))
suppressMessages(library(Hmisc))
gdp.file <- 'q3-gdp.csv'
edu.file <- 'q3-edu.csv'
if(!file.exists(gdp.file)) { download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv', gdp.file, method='curl') }
if(!file.exists(edu.file)) { download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv', edu.file, method='curl') }
gdp <- read.table(gdp.file, sep=',', skip=3, header=T, quote="\"", nrows=191)
#gdp %>% summarise_each(funs(sum(!is.na(.)))) %>% unlist(use.names=F) != 0
gdp <- gdp[,colSums(is.na(gdp)) < nrow(gdp)]
edu <- tbl_df(read.csv(edu.file, header=T, comment.char=''))
suppressWarnings( gdp %>% inner_join(edu, by=c("X" = "CountryCode")) %>% arrange(desc(Ranking)) -> join)
cat('q3 answer:', nrow(join), 'matches and 13th pos is', toString(join$Short.Name[13]), '\n\n')

# q4 section
join %>% group_by(Income.Group) %>% summarise(average.rank=mean(Ranking)) -> rank.summary
cat('q4 answer:', rank.summary$average.rank[c(2,1)], '\n\n')

# q5 section
join %>% mutate(gdp.groups=cut2(Ranking, g=5)) %>% group_by(Income.Group) %>% filter(Income.Group == 'Lower middle income' & gdp.groups=='[  1, 39)') %>% select(X, Ranking, Economy, Income.Group, gdp.groups) -> gdp.cut
cat('q5 answer: there are',nrow(gdp.cut),'countries that meet the conditions. Countries given below...\n\n')
print(gdp.cut)
