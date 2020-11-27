# lec11_2_svm.r
# 서포트벡터머신II
# Classification 
# support vector machine using kernel
# 커널

# install package for support vector machine
# install.packages("e1071")
library (e1071)
# help(svm)

# 오분류율 교차표(confusion matrix) 생성을 위한 패키지
# install package for confusionMatrix
install.packages("caret")
library(caret)

# set working directory
setwd("D:/tempstore/moocr/wk11")

# read data
iris<-read.csv("iris.csv")
attach(iris)

# 학습데이터와 검증데이터 분할
# training (100) & test set (50)
set.seed(1000, sample.kind="Rounding")
N=nrow(iris)
tr.idx=sample(1:N, size=N*2/3, replace=FALSE)
# target variable
y=iris[,5]
# split train data and test data
train=iris[tr.idx,]
test=iris[-tr.idx,]

#svm using kernel
help("svm")
m1<-svm(Species~., data = train) #디폴트는 radial basis function
summary(m1)
m2<-svm(Species~., data = train,kernel="polynomial") #커널함수를 polynomial
summary(m2)
m3<-svm(Species~., data = train,kernel="sigmoid") #커널함수를 sigmoid
summary(m3)
m4<-svm(Species~., data = train,kernel="linear") #커널함수를linear
summary(m4)

#measure accuracy
#gamma의 디폴트 = 1/data dimension
#정확도 측정
pred11<-predict(m1,test) # radial basis #m1의 서포트벡터머신에 대한 test결과
confusionMatrix(pred11, test$Species)
#table(pred11, y[-tr.idx])

pred12<-predict(m2,test) # polynomial
confusionMatrix(pred12, test$Species)
#table(pred12, y[-tr.idx])

pred13<-predict(m3,test) # simoid
confusionMatrix(pred13, test$Species)
#table(pred13, y[-tr.idx])

pred14<-predict(m4,test) # linear
confusionMatrix(pred14, test$Species)
#table(pred14, y[-tr.idx])

CrossTable(test$Species, pred14)

