library(data.tree)
data(mushroom)
playTennis <- read.csv('./play-tennis.csv')

source('./decision-tree.R')

# assumes response variable is right most column)
TrainID3 <- function(node, data) {

  node$obsCount <- nrow(data)

  #if the data-set is pure (e.g. all toxic), then
  if (IsPure(data)) {
    #construct a leaf having the name of the pure feature (e.g. 'toxic')
    child <- node$AddChild(unique(data[,ncol(data)]))
    node$feature <- tail(names(data), 1)
    child$obsCount <- nrow(data)
    child$feature <- ''
  } else {
    #chose the feature with the highest information gain (e.g. 'color')
    ig <- sapply(colnames(data)[-ncol(data)], 
                 function(x) InformationGain(
                                             table(data[,x], data[,ncol(data)])
                                             )
                 )
    feature <- names(ig)[ig == max(ig)][1]

    node$feature <- feature

    #take the subset of the data-set having that feature value
    childObs <- split(data[,!(names(data) %in% feature)], data[,feature], drop = TRUE)

    for(i in 1:length(childObs)) {
      #construct a child having the name of that feature value (e.g. 'red')
      child <- node$AddChild(names(childObs)[i])

      #call the algorithm recursively on the child and the subset      
      TrainID3(child, childObs[[i]])
    }

  }
}
tree<-Node$new('mushroom')

TrainID3(tree, mushroom)
print(tree, 'obsCount', 'feature')

tree<-Node$new("Play Tennis?")

TrainID3(tree, playTennis)
print(tree, 'obsCount', 'feature')
