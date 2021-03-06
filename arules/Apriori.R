df<-as.data.frame(Titanic)
titanic.raw<-NULL
for(i in 1:4){
  titanic.raw<-cbind(titanic.raw,rep(as.character(df[,i]),df$Freq))
}
titanic.raw<-as.data.frame(titanic.raw)
names(titanic.raw)<-names(df)[1:4]

library(arules)
rules.all<-apriori(titanic.raw)

rules<-apriori(titanic.raw,control = list(verbose=F),
               parameter = list(minlen=2,supp=0.005,conf=0.8),
               appearance = list(rhs=c("Survived=No","Survived=Yes"),default="lhs"))

##find redudant rules
rules.sorted<-sort(rules,by="lift")
subset.matrix<-is.subset(rules.sorted,rules.sorted)
subset.matrix[lower.tri(subset.matrix,diag = T)]<-NA
redundant<-colSums(subset.matrix,na.rm = T)>=1
rules.pruned<-rules.sorted[!redundant]

library(arulesViz)