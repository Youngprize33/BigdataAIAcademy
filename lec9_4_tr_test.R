# lec9_4_tr_test.R
# 데이터마이닝과 분류 - 학습데이터와 검증데이터 -
# classification 
# training data and test data

# set working directory
setwd("D:/tempstore/moocr/wk9")

# read csv file
iris<-read.csv(file="iris.csv")
head(iris)
str(iris)
attach(iris)

# training/ test data : n=150
# 분할은 2:1로 시행, 동일한 학습데이터를 위해 set.seed
set.seed(1000, sample.kind="Rounding") #version 업데이트 필요한듯
#구버전에서는 sample.kind 필요 없음
N=nrow(iris)
tr.idx=sample(1:N, size=N*2/3, replace=FALSE) # 100개의 무작위로 선정된 100개의 데이터 아이디
tr.idx

# attributes in training and test
# 5번째 열의 종속변수를 제외한 데이터
iris.train<-iris[tr.idx,-5] #100개의 데이터
iris.test<-iris[-tr.idx,-5] #50개의 데이터

# iris데이터의 타겟변수 (학습데이터의 타겟변수, 검증데이터의 타겟변수)
# target value in training and test
trainLabels<-iris[tr.idx,5]
testLabels<-iris[-tr.idx,5]

# to get frequency of class in test set
table(testLabels)

