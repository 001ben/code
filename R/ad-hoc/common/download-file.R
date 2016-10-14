url <- 'a'
filename <- 'b'
if (!file.exists(filename)) {
  download.file(url, filename, method='curl')
}
