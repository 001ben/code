# Follows Q6.41 in Intro Statistics.

# First val is observed, second val is expected. Corresponds to ways different students access textbook
observed_and_expected <- list(
  list(71, 75.6), # hardcopy
  list(30, 31.5), # print from web
  list(25, 18.9)  # read online
)

r1 <- sapply(a, function(x) { 
  (x[[1]] - x[[2]])^2 / x[[2]]} # Chi-Square distance formula
)
chisq.val <- sum(r1)

# Calculate degrees of freedom
df <- length(observed_and_expected) - 1

# Calculate and print the p-val of the chisquare test statistic
print(pchisq(chisq.val, df))
