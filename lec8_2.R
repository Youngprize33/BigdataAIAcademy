# lec8_2.r : Linear model 
# 회귀분석(선형모형)
# Regression

# set working directory
setwd("D:/tempstore/moocr")

# autompg data
car<-read.csv("autompg.csv")
head(car)
str(car)

# subset with cyl=4,6,8
car1<-subset(car, cyl==4 | cyl==6 | cyl==8)
attach(car1)

# 1. simple Regression(independent variable : wt)
# 단순선형회귀모형: lm(y변수~x변수,data= )
# 종속변수: mpg(연비), 독립변수: wt(차량무게)
r1<-lm(mpg~wt, data=car1)
summary(r1)
anova(r1)

# (lec4_3.R) scatterplot with best fit lines
# 산점도에 회귀선 그리기
# plot(x변수, y변수) abline: add line(선을 추가하는 함수), lm(y변수~x변수): lm은 linear model(선형 모형)의 약자
par(mfrow=c(1,1))
plot(wt, mpg,  col=as.integer(car1$cyl), pch=19)
# best fit linear line
abline(lm(mpg~wt), col="red", lwd=2, lty=1)

# 회귀분석의 목적: 예측(prediction)과 추정(estimation)
# 선형모형: 독립변수와 종속변수 간의 관계가 선형식으로 적합

# 2. simple Regression(independent variable : disp), disp는 배기량
r2<-lm(mpg~disp, data=car1)
summary(r2)
anova(r2)

# residual diagnostic plot (잔차의 산점도) 
# 잔차가 정규분포를 따르는지 등
# 회귀분석의 가정과 진단
layout(matrix(c(1,2,3,4),2,2)) # optional 4 graphs/page 
plot(r2)

# 다중회귀분석 : 독립변수가 여러 개인 경우
# 3. multiple Regression
r3<-lm(mpg~wt+accler, data=car1)
summary(r3)
anova(r3)

# pariwise plot
pairs(car[, 1:6],cex=1, col=as.integer(car$cyl),pch =substring((car$cyl),1,1))

# new variable lists
# vars1<-c("mpg", "disp", "wt", "accler")
# pariwise plot
# pairs(car[vars1], main ="Autompg",cex=1, col=as.integer(car$cyl),pch =substring((car$cyl),1,1))

# par(mar=c(4,4,4,4))
# par(mfrow=c(1,1))
# plot(disp, mpg,  col=as.integer(car1$cyl), pch=19)
# best fit linear line
# abline(lm(mpg~disp), col="red", lwd=2, lty=1)






