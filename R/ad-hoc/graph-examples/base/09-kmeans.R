# watch out for the max number of iterations and the number of starts you want for randomness
x <- rnorm(12)
y <- rnorm(12)
df <- data.frame(x,y)

km <- kmeans(df, 3)
plot(df, col=km$cluster, pch=19, cex=2)
points(km$centers, col=1:3, pch=3, cex=3, lwd=3)
