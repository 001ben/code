# Run interactively, not with Rscript
library(ISLR)

attach(Auto, warn.conflicts=F)
mpg.lm <- lm(mpg~horsepower)
mpg.sum <- summary(mpg.lm)
plot(mpg.lm$fitted.values, mpg.sum$residuals)
lines(lowess(mpg.lm$fitted.values, mpg.sum$residuals), col="red")
cat('plotted linear residuals. Press any key to continue...\n')
readline()

mpg.lm <- lm(mpg~horsepower+I(horsepower^2))
mpg.sum <- summary(mpg.lm)
plot(mpg.lm$fitted.values, mpg.sum$residuals)
lines(lowess(mpg.lm$fitted.values, mpg.sum$residuals), col="red")
cat('plotted quadratic residuals. Press any key to continue...\n')
readline()

mpg.lm <- lm(mpg~horsepower+I(horsepower^2)+I(horsepower^3))
mpg.sum <- summary(mpg.lm)
plot(mpg.lm$fitted.values, mpg.sum$residuals)
lines(lowess(mpg.lm$fitted.values, mpg.sum$residuals), col="red")
cat('plotted cubic residuals\n')
