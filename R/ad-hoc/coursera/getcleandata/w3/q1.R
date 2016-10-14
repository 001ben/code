filename <- 'q1.csv'
if (!file.exists(filename)) {
  download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv', filename, method='curl')
}
dat <- read.csv("q1.csv", header=T)
agricultureLocal <- dat$ACR == 3 & dat$AGS == 6
print(which(agricultureLocal))
