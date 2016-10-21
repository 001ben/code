#Download data
url <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
zip.filename <- 'assign-data.zip'
if (!file.exists(zip.filename)) {
  download.file(url, zip.filename, method='curl')
} else {
  cat('Data has already been downloaded\n')
}

if(!file.exists('UCI HAR Dataset')) {
  unzip(zip.filename)
}

setwd('UCI HAR Dataset')

# read-in data
suppressMessages(library(dplyr))

cat('reading test set...\n')
x.test <- tbl_df(read.table('./test/X_test.txt')) 

cat('reading train set...\n')
x.train <- tbl_df(read.table('./train/X_train.txt'))


cat('reading aditional info...\n')
activity.col <- 'activity'
activity.id <- 'activity.id'

activity.labels <- tbl_df(read.table('./activity_labels.txt', col.names=c(activity.id, activity.col)))
x.test.labels <- tbl_df(read.table('./test/y_test.txt', col.names=activity.id))
x.train.labels <- tbl_df(read.table('./train/y_train.txt', col.names=activity.id))

subject.col  <- 'subject'
x.test.subjects <- tbl_df(read.table('./test/subject_test.txt', col.names=subject.col))
x.train.subjects <- tbl_df(read.table('./train/subject_train.txt', col.names=subject.col))

# cleaning up names...
cat('cleaning up names...\n')
features <- readLines('./features.txt') %>%
  strsplit(' ') %>% # split on spaces to separate names and #'s
  sapply(function(x) { x[2] }) # only take the name

indexes <- features %>% 
  grep('mean\\(\\)|std\\(\\)', .)

clean.names <- features[indexes] %>% 
  gsub('-','', .) %>% # remove all hyphens
  gsub('([A-Z])', '_\\1', .) %>% # insert an underscore before all capital names to space it out and make all lowercase
  tolower %>%
  sub('^t', 'time_domain', .) %>% # t means time domain
  sub('^f', 'frequency_domain', . ) %>% # f means frequency domain
  gsub('acc', 'acceleration', .) %>% # acc means accelerations
  gsub('mean\\(\\)', '_mean', .) %>% # remove brackets and add underscore
  gsub('std\\(\\)', '_standard_deviation', .) %>% # remove brackets and add underscore
  gsub('mag', 'magnitude', .)

x.test <- select(x.test, indexes)
x.train <- select(x.train, indexes)
names(x.test) <- clean.names
names(x.train) <- clean.names

# joining all data
cat('joining data...\n')

x.test <- bind_cols(x.test, x.test.labels, x.test.subjects)
x.train <- bind_cols(x.train, x.train.labels, x.train.subjects)
x <- bind_rows(x.test, x.train)

suppressMessages(x <- x %>%
                 inner_join(activity.labels) %>% 
                 select(-activity.id))

# Summarizing data
cat('saving data to tidy-dataset.txt...\n')
tidy <- x %>%
  group_by(activity, subject) %>%
  summarise_all(funs(mean))

write.table(tidy, '../tidy-dataset.txt')
