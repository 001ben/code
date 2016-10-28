url <- 'https://raw.githubusercontent.com/DataScienceSpecialization/courses/master/04_ExploratoryAnalysis/dimensionReduction/data/face.rda'
filename <- 'face.rda'
if (!file.exists(filename)) {
  download.file(url, filename, method='curl')
}

load(filename)

rotate <- function(x) { 
  t(apply(x, 2, rev))
}
image(rotate(faceData))
cat('this is the original face image\n')
cat('press any key to continue...\n')
invisible(readline())

reduct <- svd(faceData)
reducedImage <- reduct$u[,1:10] %*% diag(reduct$d[1:10]) %*% t(reduct$v[,1:10])

dev.new()
image(rotate(reducedImage))
cat('this is the reduced face built with only 10/32 columns from the full svd\n')
cat('press any key to continue...\n')
invisible(readline())
if(!is.null(dev.list())) invisible(dev.off())
if(!is.null(dev.list())) invisible(dev.off())
