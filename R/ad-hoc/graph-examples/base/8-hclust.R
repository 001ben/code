# Varying the distance measure and linkage type can impact how the data clusters and should be experimented with
dist.measure <- 'euclidean'            # can be euclidean, city block (manhattan), ...
cluster.method <- 'average'            # can be complete, average, ...

m.x <- rnorm(10)
m.y <- rnorm(10)

df <- data.frame(x=m.x, y=m.y)
df.dist <- dist(df, method=dist.measure)
df.hclust <- hclust(df.dist, method=cluster.method)

# vanilla hierarchial cluster
plot(df.hclust)

# printing as dendrogram
plot(as.dendrogram(df.hclust))
abline(h=2, col='navyblue')

# multi variable hierarchial clustering
mtcar.sample <- mtcars[sample(nrow(mtcars), size=10), ]
mtcar.dist <- dist(mtcar.sample, method=dist.measure)
mtcar.hclust <- hclust(mtcar.dist, method=cluster.method)
plot(mtcar.hclust)
