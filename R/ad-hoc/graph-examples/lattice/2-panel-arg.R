# using example from the swirl lesson on lattice
library(lattice)
attach(mtcars)

p2 <- xyplot(wt ~ hp | as.factor(cyl), layout=c(3,1), panel = function(x, y, ...) {
  panel.xyplot(x, y, ...)  ## First call default panel function
  panel.lmline(x, y, col = 2)  ## Overlay a simple linear regression line
})
print(p2)
invisible()
