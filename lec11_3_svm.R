# lect11_3_svm.r
# 서포트벡터머신III
# Classification
# Support vector machine using kernel

# install.packages("e1071")
# load package for support vector machine
library(e1071) #svm model

install.packages("caret")
# load package for Confusion matrix
library(caret)

# set working directory
setwd("D:/tempstore/moocr/wk11")

# read data
cancer<-read.csv("cancer.csv")
head(cancer, n=10) #첫번째 10줄 데이터 보기

# remover X1 column(ID number)
# ID number는 필요없는 feature이므로 삭제
cancer<-cancer[, names(cancer) != "X1"]
attach(cancer)

# 데이터 분할 (2/3, 1/3)
# training (455) & test set (228)
# set.seed(1000)
N=nrow(cancer)
set.seed(998, sample.kind="Rounding")

# split train data and test data
tr.idx=sample(1:N, size=N*2/3, replace=FALSE)
train <- cancer[ tr.idx,]
test  <- cancer[-tr.idx,]

#svm using kernel
m1<-svm(Y~., data = train)
summary(m1)
m2<-svm(Y~., data = train,kernel="polynomial")
summary(m2)
m3<-svm(Y~., data = train,kernel="sigmoid")
summary(m3)
m4<-svm(Y~., data = train,kernel="linear")
summary(m4)

#measure accuracy
#정확도 측정
#병의 진단은 false positive와 false negative중 어느 것이 중요한지를 고려해야 한다!
#악성인데 정상으로 판단하는 것이 더 위험하다! 즉, false negative가 더 위험
pred11<-predict(m1,test) # radial basis
confusionMatrix(pred11, test$Y)
#table(pred11, y[-tr.idx])

pred12<-predict(m2,test) # polynomial
confusionMatrix(pred12, test$Y)
#table(pred12, y[-tr.idx])

pred13<-predict(m3,test) # sigmoid
confusionMatrix(pred13, test$Y)
#table(pred13, y[-tr.idx])

pred14<-predict(m4,test) # linear
confusionMatrix(pred14, test$Y)
#table(pred14, y[-tr.idx])

library(gmodels)
CrossTable(pred14, test$Y)

