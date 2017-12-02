IsPure <- function(data) {
  length(unique(data[,ncol(data)])) == 1
}

# take the counts of true/positive labels i.e.
# Entropy(c(4,5)) : where 4 are true, and 5 are false (or whatever)
Entropy <- function(vls) {
  res <- vls/sum(vls) * log2(vls/sum(vls))
  res[vls==0] <- 0
  -sum(res)
}

# Expect table of 2 variables with counts i.e
#       edibility
# points edible toxic
#    no       3     0
#    yes      1     1
InformationGain <- function(tble) {
  # converts table into matrix
  #     edible toxic
  # no       3     0
  # yes      1     1
  tble <- as.data.frame.matrix(tble)                                   

  # calculate entropy over the colSums: 
  # edible  toxic
  #      4      1 
  # 
  # entropy: Entropy(4,1) = 0.7219281
  entropyBefore <- Entropy(colSums(tble))                              

  # pre-caculate the overall row sums
  #  no yes
  #   3   2
  s <- rowSums(tble)                                                   

  # get entropy for each row in separately, and compute weighted sum of entropy's
  #     percentage  entropy           result
  # no  0.6 (3/5)   0 (Entropy(3,0))  0.0   
  # yes 0.4 (2/5)   1 (Entropy(1,1))  0.4   
  # entropyAfter = 0.0 + 0.4 = 0.4
  entropyAfter <- sum(s / sum(s) * apply(tble, MARGIN=1, FUN=Entropy)) 

  # self explanatory
  # informationGain  0.3219281
  informationGain <- entropyBefore - entropyAfter                      # 

  return (informationGain);                                            # 
}

GraphEntropy <- function() {
  entropy <- function(edible) Entropy(c(edible, 100-edible))
  entropy <- Vectorize(entropy)
  curve(entropy, from=0, to=100, xname='edible')
}
