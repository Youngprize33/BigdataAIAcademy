# lec8_1.r
# 상관분석
# Correlation coefficent
# 상관계수: cor(변수1, 변수2)

# set working directory
setwd("D:/tempstore/moocr")

# autompg data
car<-read.csv("autompg.csv")
#head(car)
#dim(car)

# subset of car : cyl (4,6,8)
car1<-subset(car, cyl==4 | cyl==6 | cyl==8)
attach(car1)

# cor의 디폴트는 pearson의 상관계수
# kendall의 상관계 혹은 spearman의 상관계수를 구할때는
# cor(변수1,변수2, method=c("spearman"))

#correlation
cor(wt, mpg)
cor(disp, mpg)
cor(accler, mpg)

# 상관계수와 산점도
# 6. pariwise plot
# new variable lists
vars1<-c("disp", "wt", "accler", "mpg")
# pariwise plot
pairs(car1[vars1], main ="Autompg",cex=1, col=as.integer(car1$cyl),pch =substring((car1$cyl),1,1))
# 1)차량무게와 배기량과는 정비례관계 (양의상관계수)
# 2)MPG(연비)와 (wt, disp)는 상관성이 높다. (반비례 음의 상관계수)
# 3)cylinder별로 색으로 표시 (파란색:4, 진한핑크:6, 회색:8)
# 상관계수(r)는 절대값이 0에서 1사이이다. 0에 가까울수록 상관관계가 없다. 1일수록 강한 상관성이 있다.

## 통계치와 그래프 - Monkey 데이터 + king kong 한마리
## 이상치의 존재로 상관성에 대한 결과값이 바뀔 수 있다.
## 한 마리의 킹콩 데이터가 몸무게와 신장 간  상관관에 대한 해석을 완전히 바꿔놓을 수 있다.
## Watch out!!
## Monkey data
monkey<-read.csv("monkey.csv")
head(monkey)
dim(monkey)
attach(monkey)

# correlation coefficients
cor(height, weight)
# scatterplot for weight and height
par(mfrow=c(1, 1))
plot(height, weight, pch=16, col=3,main="Monkey data")

# add the best fit linear line (lec4_3.R)
abline(lm(weight~height), col="blue", lwd=2, lty=1)

# linear model and summary of linear model
m1<-lm(weight~height)
summary(m1)

## Monkey data + Kingkong
monkey1<-read.csv("monkey_k.csv")
head(monkey1)
dim(monkey1)
attach(monkey1)

# correlation coefficients
cor(height, weight)
# scatterplot for weight and height
par(mfrow=c(1, 1))
plot(height, weight, pch=16, col=3,main="Monkey data")

# add the best fit linear line (lec4_3.R)
abline(lm(weight~height), col="red", lwd=2, lty=1)

# linear model and summary of linear model for monkey+king kong
m2<-lm(weight~height)
summary(m2)

  