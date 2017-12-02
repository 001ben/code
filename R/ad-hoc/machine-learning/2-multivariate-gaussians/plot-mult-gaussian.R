package <- c('mvtnorm', 'threejs', 'mclust')
for(p in package) {
    if(!p %in% installed.packages()) {
        install.packages(p, repos = 'https://cran.csiro.au/')
    }
    library(p, character.only=T)
}

library(ggplot2)
#threejs::globejs

# Circular standard norm
sigma <- diag(2)
mean <- c(0,0)
x <- rmvnorm(n=1000, mean = mean, sigma=sigma)
d <- data.frame(x=x[,1], y=x[, 2])
ggplot(d, aes(x, y)) +
    geom_density_2d()

# Oval Sigma
sigma <- matrix(c(1,1,1,1), ncol=2)
mean <- c(0,0)
x <- rmvnorm(n=1000, mean = mean, sigma=sigma)
d <- data.frame(x=x[,1], y=x[, 2])
ggplot(d, aes(x, y)) +
    geom_density_2d()

# Oval in other direction Sigma
sigma <- matrix(c(1,-1,-1,1), ncol=2)
mean <- c(2,-3)
x <- rmvnorm(n=1000, mean = mean, sigma=sigma)
d <- data.frame(x=x[,1], y=x[, 2])
ggplot(d, aes(x, y)) +
    geom_density_2d()

# Fitting (Fitting Spherical to the oval, bad)
r <- mvn(modelName='Spherical', x)
r_mean <- r$parameters$mean[, 1]
r_sigma <- r$parameters$variance$sigma[, , 1]
r_x <- rmvnorm(n=1000, mean = r_mean, sigma = r_sigma)
r_d <- data.frame(x=r_x[, 1], y=r_x[,2])
ggplot(r_d, mapping=aes(x, y)) +
    geom_density_2d()

# Fitting (Fitting an ellipse to the oval, good)
r <- mvn(modelName='Ellipsoidal', x)
r_mean <- r$parameters$mean[, 1]
r_sigma <- r$parameters$variance$sigma[, , 1]
r_x <- rmvnorm(n=1000, mean = r_mean, sigma = r_sigma)
r_d <- data.frame(x=r_x[, 1], y=r_x[,2])
ggplot(r_d, mapping=aes(x, y)) +
    geom_density_2d()

