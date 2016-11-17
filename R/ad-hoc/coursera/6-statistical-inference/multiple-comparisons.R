set.seed(1000102)
pValues <- rep(NA, 1000)
for(i in 1:1000) {
  y <- rnorm(20)
  x <- if(i<=500) {rnorm(20)} else { rnorm(20, mean = 2*y)}
  pValues[i] <- summary(lm(y ~ x))$coeff[2,4]
}

trueStatus <- rep(c('zero', 'not zero'), each=500)

# without correction
table(pValues < 0.05, trueStatus)

# no false positives
# with family wise correction - controlling the probability of even one false positive
table(p.adjust(pValues, method='bonferroni') < 0.05, trueStatus)

# All True Positives, but more false positives
# with false discovery rate correction - controlling the probability of missing any discoveries
table(p.adjust(pValues, method='BH') < 0.05, trueStatus)

# Plotting both graphs
par(mfrow=c(1,2))
plot(pValues, p.adjust(pValues, method='bonferroni'), pch=19)
plot(pValues, p.adjust(pValues, method='BH'), pch=19)

# Further notes - for further corrections consider method = 'BY'