# Defining color display function
showColors <- function(cv){
    myarg <- deparse(substitute(cv))
  z<- outer( 1:20,1:20, "+")
    obj<- list( x=1:20,y=1:20,z=z )
    image(obj, col=cv, main=myarg  )
}

blue.to.red <- colorRampPalette(c('blue', 'red'))
showColors(blue.to.red(50))

#Color Brewer Demo
library(RColorBrewer)
blue.green <- brewer.pal(3, 'BuGn')
showColors(blue.green)
