# lec10_4_QDA.R
# 판별분석II - 이차판별분석
# Quadratic Discriminant Analysis

# MASS package for LDA
# install.packages("MASS")
library(MASS)

# install.packages("gmodels") #crosstable
library(gmodels)

# set working directory
setwd("D:/tempstore/moocr/wk10")

# read csv file
iris<-read.csv("iris.csv")
attach(iris)

# training/ test data : n=150
set.seed(1000, sample.kind="Rounding")
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

# 이차판별분석 전에 분산이 동일한가에 대한 검정이 필요하다.
# Box's M-test for Homogenity of Covariance Matrices
install.packages("biotools")
library(biotools)
boxM(iris[1:4], iris$Species)

# QDA함수 : qda(종속변수~독립변수, data=학습데이터 이름, prior=사전확률)
# Quadratic Discriminant Analysis (QDA)
iris.qda <- qda(Species ~ ., data=train, prior=c(1/3,1/3,1/3))
iris.qda

# 검증데이터에 QDA결과를 적용하여 범주 추정
# class -> 추정범주
# posterior -> 세 개 범주의 사후 확률(posterior probability)을 구한 후 max값을 범주로 할당
# predict test data set n=50
testpredq <- predict(iris.qda, test)
testpredq

# 정확도 산정 : 오분류율 (검증데이터)
# accuracy of QDA
CrossTable(x=testLabels,y=testpredq$class, prop.chisq=FALSE)
# 정확도 49/50 -> 98%
# versicolor를 virginica로 잘못 예측
# 오분류율 1/50 -> 2%

# LDA vs QDA (Partition Plot)
# Partition plot : partimat()
# 추가적으로 보는 것으로, factor변수의 정의 필요
# LDA의 결과와 QDA의 결과를 보여주는데,
# 4개의 변수를 2개씩 pair로 그래프가 6개가 생기는데
# 어느 2개의 combination이 3개의 범주가 spilit을 잘 보여주는지
# 여기서는 LDA에서는 (2,3)그래프가
# QDA에서도 (2,3)그래프가 잘 보여줌 그 그래프의 (x,y)축 변수가 잘 split한다는 뜻
# 그래프 상단에는 오분류율을 나타냄
# partimat() function for LDA & QDA
install.packages("klaR")
library(klaR)
partimat(as.factor(iris$Species) ~ ., data=iris, method="lda")
partimat(as.factor(iris$Species) ~ ., data=iris, method="qda")





# stacked histogram
ldahist(data=testpred$x[,1], g=iris$Species, xlim=range(-10:10), ymax=0.7)
ldahist(data=testpred$x[,2], g=iris$Species, xlim=range(-10:10), ymax=0.7)

