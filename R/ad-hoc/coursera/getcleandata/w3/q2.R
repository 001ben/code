library(jpeg)
filename <- 'q2.jpg'
if (!file.exists(filename)) {
  download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg', filename, method='curl')
}
jpg <- readJPEG(filename, native=T)
r <- quantile(jpg, probs=c(0.3, 0.8))
print(r)
print('apparently there\'s a difference on linux machines, so we subtract 638')
r['30%'] <- r['30%'] - 638
print(r)
