# lec11_1_svm.r
# 서포트벡터머신I
# Classification
# support vector machine (e1071)
# 타겟값이 있는 모형 중 분류모형
# 타겟이 class범주
# x1변수와 x2변수를 분리하는 선의 margin을 최대화하는 벡터 찾기

# 서포트벡터머신을 위한 패키지
# install package for support vector machine
install.packages("e1071")
library (e1071)
#help(svm)

# set working directory
setwd("D:/tempstore/moocr/wk11")

# read data
# input변수(독립변수) - Sepal.Length, Sepal.Width, Petal.Length, Petal.Width
# output변수(종속변수) - Species
# 타겟변수(y) : setosa, versicolor, virginica
iris<-read.csv("iris.csv")
attach(iris)

## classification 
# 서포트벡터머신 함수 : svm(y변수~x변수, data= )
# iris데이터의 서포트벡터머신 결과 (전체데이터의 경우)
# 1. use all data 
m1<- svm(Species ~., data = iris, kernel="linear")
summary(m1)

# classify all data using svm result (m1)
# first 4 variables as attribute variables
x<-iris[, -5]
pred <- predict(m1, x)

# Check accuracy (compare predicted class(pred) and true class(y))
# y <- Species or y<-iris[,5]
y<-iris[,5]
table(pred, y)

# SVM결과 시각화
# visualize classes by color
plot(m1, iris,  Petal.Width~Petal.Length, slice=list(Sepal.Width=3, Sepal.Length=4))
# 4개의 변수 중 petal.width와 petal.length가 중요변수

