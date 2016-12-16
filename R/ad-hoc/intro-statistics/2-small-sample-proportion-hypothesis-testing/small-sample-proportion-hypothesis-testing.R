simulations<-10000
totalNumber<-62
nullProb<-0.1
altProb<-0.048

nullDistro <- replicate(simulations, sum(runif(totalNumber) < nullProb))
hist(nullDistro)

proportionLowerThanAlt <- nullDistro / 64 < altProb
totalLowerThanAlt <- sum(proportionLowerThanAlt)

cat('lower than or equal to alt: ', totalLowerThanAlt, '\n')
cat('p-value: ', totalLowerThanAlt / simulations, '\n')
