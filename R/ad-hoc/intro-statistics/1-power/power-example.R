# For Q5.39. Power = 0.9, SD = 94, Minimum change of interest = 40, sig.level = 0.05

## manual way
Z.power <- qnorm(.975) + qnorm(.9)
standard.deviation <- 94
effect <- 40

## rearranging the formula -- Confidence <- Z * sqrt(sd.1^2/n + sd.1^2/n)
## we get -- n <- (Z^2 / Confidence^2) * (standard.deviation^2 + standard.deviation^2)
Z.power ^ 2 / effect^2 * (standard.deviation^2 + standard.deviation^2)

## Or we could use the "pwr" library
library(pwr)
pwr.2p.test(h = 40/94, power = .9)