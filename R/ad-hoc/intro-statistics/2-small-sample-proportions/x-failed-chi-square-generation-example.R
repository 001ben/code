fullSize<-60
dist <- rbinom(n=60, size=fullSize, prob=.3)
a<-table(dist)
b<-a/sum(a)
c<-function() {
	l <- 0:fullSize
	vec <- list()
	for(i in l) {
		vec[i+1] = pbinom(i,size=60,prob=.3, lower.tail=F) - 
			pbinom(i+1,size=60,prob=.3, lower.tail=F)
	}
	unlist(vec)
}
d<-c()

for(i in names(b)) {
	r<-0
	r+=(b[i]-c[i])^2/c[i]
}

# At this point i realised it probably wasn't worth actually completing the example 
# as the binomial example given in 6.5.3 only had 2 categories (lower than 3 and 
# greater than 3), rather than treating each number as a category XD
