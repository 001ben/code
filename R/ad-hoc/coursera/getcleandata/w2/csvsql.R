library(sqldf)
acs <- read.csv.sql("pid.csv")
dim(acs)
sql <- "select * from acs" ; sql
result <- sqldf(sql)
dim(result)
