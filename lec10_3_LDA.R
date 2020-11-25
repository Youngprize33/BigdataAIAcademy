# lec10_3_LDA.R
# 판별분석1 - 선형판별분석
# Linear Discriminant Anlaysis

# install the MASS package for LDA
install.packages("MASS")
library(MASS)

# install.packages("gmodels") #crosstable
library(gmodels)

# set working directory
setwd("D:/tempstore/moocr/wk10")

# read csv file
iris<-read.csv("iris.csv")
attach(iris)

# training/ test data : n=150

set.seed(1000,sample.kind="Rounding")

N=nrow(iris)
tr.idx=sample(1:N, size=N*2/3, replace=FALSE)

# attributes in training and test
iris.train<-iris[tr.idx,-5]
iris.test<-iris[-tr.idx,-5]
# target value in training and test
trainLabels<-iris[tr.idx,5]
testLabels<-iris[-tr.idx,5]

train<-iris[tr.idx,]
test<-iris[-tr.idx,]

# Linear Discriminant Analysis (LDA) with training data n=100
# 선형판별분석 패키지(MASS)설치
# LDA함수: lda(종속변수 ~ 독립변수, data=학습 데이터 이름, prior= 사전확률)
# 사전확률: 원인A가 발생할 확률인 P(A)와 같이 결과가 나타나기 전에 결정되어있는 확률
iris.lda <- lda(Species ~ ., data=train, prior=c(1/3,1/3,1/3))
iris.lda

# predict test data set n=50
testpred <- predict(iris.lda, test)
testpred
#Quiz
testpred1<-round(testpred$posterior, 2)
testpred1


# accuracy of LDA
# 정확도 산정: 오분류율(검증 데이터)
CrossTable(x=testLabels,y=testpred$class, prop.chisq=FALSE)

# export csv file - write out to csv file 
write.table(testpred$posterior,file="posterior_iris.csv", row.names = TRUE, sep=",", na=" ")
write.table(test, ,file="test_iris.csv", row.names = TRUE, sep=",", na=" ")


# stacked histogram
# ldahist(data=testpred$x[,1], g=iris$Species, xlim=range(-10:10), ymax=0.7)
# ldahist(data=testpred$x[,2], g=iris$Species, xlim=range(-10:10), ymax=0.7)
