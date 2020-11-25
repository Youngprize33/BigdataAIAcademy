# lec9_2_MLR.r
# 데이터마이닝과 예 - 다중회귀분석 II -
# Multiple Regression
# Explanatory Data analysis

# set working directory
setwd("D:/tempstore/moocr/wk9")

# autompg data
car<-read.csv("autompg.csv")
head(car)
str(car)
attach(car)

# multiple regression : 1st full model 
r1<-lm(mpg ~ disp+hp+wt+accler, data=car)
summary(r1)

# pariwise plot - Explanatory Data Analysis
var1<-c("mpg","disp","hp","wt", "accler" )
pairs(car[var1], main ="Autompg",cex=1, col=as.integer(car$cyl))

######## lec9_2_MLR.R #########

# 2rd model using variable selection method
# 변수선택법 - 단계별 방법
# step(r1, direction="forward")
# step(r1, direction="backward")
# stepwise selection
step(r1, direction="both")
#step(lm(mpg ~ disp+hp+wt+accler, data=car), direction="both")

# final multiple regression
# 단계별 방법에 따른 최종 다중회귀모형
r2<-lm(mpg ~ disp+wt+accler, data=car)
summary(r2)

# residual diagnostic plot 
# 회귀분석의 가정과 진단
layout(matrix(c(1,2,3,4),2,2)) # optional 4 graphs/page 
plot(r2)

# check correlation between independent variables
var2<-c("disp","hp","wt", "accler" )
cor(car[var2])

# get correlation for each pair
# cor(disp, wt)
# cor(disp, accler)
# cor(wt, accler)

# 다중공선(Multicollinearity) 
# 독립변수들 사이에 상관관계가 매우 높은 경우 발생하는 현상
# 독립변수들 사이에 상관관계가 있는 현상
# 다중공선성이 존재하는 경우 회귀계수 해석이 불가능하다.
# check multicollinearity 
# variance inflation factor(VIF)
# 분산팽창계수
install.packages("car")
library(car)
vif(lm(mpg ~ disp+hp+wt+accler, data=car))

# compare R-sqaured in regression 
# which one is the most important variable?
# 변수선택방법에 따른 R^2 확인하기 (Quiz 나옴)
# 연비(MPG)를 예측하기 위해 한 개의 변수만 선택한다면?
summary(lm(mpg ~ disp))
summary(lm(mpg ~ hp))
summary(lm(mpg ~ wt))
summary(lm(mpg ~ accler))

# 다중회귀모형에 대한 탐색적 분석
# 다중회귀모형 : 데이터탐색(Explanatory Data Analysis)
# more checking point
plot(hp, mpg, col="blue")

# 다중회귀모형 탐색과 진단
## 2nd model : data split
# 데이터 탐색 - subset 생성(hp<50)
# subset data hp<50
par(mfrow=c(1,1))
car_s1<-subset(car, hp<50)
plot(car_s1$hp, car_s1$mpg,col=10,  main="hp<50")
# regression for hp<50
summary(lm(car_s1$mpg ~ car_s1$hp))

# subset data hp>=50
car_s2<-subset(car, hp>=50)
plot(car_s2$hp, car_s2$mpg, col="coral", main="hp>=50")
# regression for hp>=50
summary(lm(car_s2$mpg ~ car_s2$hp))

################ additional part #######################

# model for autompg data (hp<50)
car_s1<-subset(car, hp<50)
rf1<-lm(mpg ~ disp+hp+wt+accler, data=car_s1)
summary(rf1)
# residual diagnostic plot 
layout(matrix(c(1,2,3,4),2,2)) # optional 4 graphs/page 
plot(rf1)

# model for autompg data (hp>=50)
car_s2<-subset(car, hp>=50)
rf2<-lm(mpg ~ disp+hp+wt+accler, data=car_s2)
summary(rf2)

# residual diagnostic plot 
layout(matrix(c(1,2,3,4),2,2)) # optional 4 graphs/page 
plot(rf2)


