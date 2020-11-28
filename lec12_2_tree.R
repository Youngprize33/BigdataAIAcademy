# lec12_2_tree.R
# 의사결정나무II
# Decision tree
# use package rpart and party

# 의사결정나무를 위한 다른 패키지
# other package for tree
install.packages("rpart")
install.packages("party")
library(rpart)
library(party)

#package for confusion matrix
#install.packages("caret")
library(caret)

# set working directory
setwd("D:/tempstore/moocr/wk12")

# read csv file
iris<-read.csv("iris.csv")
attach(iris)

# training (n=100)/ test data(n=50) 
set.seed(1000, sample.kind="Rounding")
N<-nrow(iris)
tr.idx<-sample(1:N, size=N*2/3, replace=FALSE)
# split train data and test data
train<-iris[tr.idx,]
test<-iris[-tr.idx,]

#decision tree : use rpart package
help("rpart")

cl1<-rpart(Species~., data=train)
plot(cl1)
text(cl1, cex=1.5)

#pruning (cross-validation)-rpart
printcp(cl1)
plotcp(cl1)

#final tree model
pcl1<-prune(cl1, cp=cl1$cptable[which.min(cl1$cptable[,"xerror"]),"CP"])
plot(pcl1)
text(pcl1)
#tree함수를 이용한 최종모형과 동일한 tree결과

#measure accuracy(rpart)
#의사결정나무결과 정확도 : test data에 대한 정확도
pred2<- predict(cl1,test, type='class')
confusionMatrix(pred2,test$Species)

#party패키지
#decision tree(party)-unbiased recursive partioning based on permutation test
partymod<-ctree(Species~.,data=train)
plot(partymod)

#정확도 검정, test data에 대해
#measuring accuracy(party)
partypred<-predict(partymod,test)
confusionMatrix(partypred,test$Species)