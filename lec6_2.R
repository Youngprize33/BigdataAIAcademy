# lec6_2.r
# 데이터의 기술통계치 요약
# Data exploration : Numerical summary statistics

# set working directory
setwd("D:/tempstore/moocr")

### student math grade data ####
# 데이터 : 학생들의 학업성취도 (포루투칼의 고등학생 수학점수)
stud<-read.csv("stud_math.csv")

head(stud)
dim(stud) #395관측치 33개 변수
str(stud)

attach(stud)

# 1-1 Numeriacl analytics
# summary(데이터이름): 각 변수별로 요약통계량 제공
# 문자변수에 대해서는 빈도를 주고, 숫자변수에 대해서 사분위수 제공
summary(stud)
mean(G3)
sd(G3)
sqrt(var(G3)) 
#mad(x) Median absoulte deviation

# creating interested variable list
# 특정변수들에 대한 요약통계량
# stud데이터는 33개의 변수를 가짐 -> 특정변수들에 대해 탐색하고자 할때
vars<-c("G1", "G2", "G3")
head(stud[vars])
summary(stud[vars])

# sapply function
sapply(stud[vars], mean)
# 얻고자하는 데이터의 column을 정하고 function을 지정

# descriptive statistics using "psych" package
# 함수 describe를 사용한 데이터요약통계 (psych 패키지 필요)
install.packages("psych")
library(psych)
# require "psych" for "describe" function
describe(stud[vars])

# categorical data
# 범주형 변수의 요약 : table(변수이름)
table(health)

health_freq<-table(health)
#막대그림 (이름주기)
names(health_freq) <- c ("very bad", "bad", "average", "good",
                      "very good")
barplot(health_freq, col=3)

# 2*2 contingency table
# 범주형 변수의 요약 : table(변수1, 변수2)
table(health,studytime)

##################

#chisq.test(health,studytime)

