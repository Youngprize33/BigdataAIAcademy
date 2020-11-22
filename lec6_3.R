# lec6_3.r
# 그래프를 이용한 데이터 탐색
# Data exploration - graphics

# set working directory
setwd("D:/tempstore/moocr")

### student math grade data ####

stud<-read.csv("stud_math.csv")

head(stud)
dim(stud)
str(stud)

attach(stud)

# 1. histogram with color and title, legend
# 히스토그램(1,2,3학년 성적분포)
par(mfrow=c(2,2))
hist(G1, breaks = 10, col = "lightblue", main="Histogram of Grade 1" )
hist(G2, breaks = 10, col = "green", main="Histogram of Grade 2" )
hist(G3, breaks = 10, col = "coral", main="Histogram of Grade 3" )

# 2. boxplot
# 상자그림 (거주지역에 따른 G3, 통학시간에 따른 G3)
par(mfrow=c(1,2))
boxplot(G3~address, boxwex = 0.5, col = c("yellow", "coral"), main="G3 by (Urban, Rural)")
boxplot(G3~traveltime, boxwex = 0.5, col = c("red","orange","yellow","green"), main="G3 by traveltime")
# 1) 도심지역 학생들 성적이 외곽지역 학생들 보다 높다
# 2) 통학시간이 짧은(15분이내)의 학생들의 성적이 더 높다
# 단편적으로 평가하는 셈

# boxplot
# 상자그림 (자유시간에 따른 G3, 공부시간에 따른 G3)

par(mfrow=c(1,2))
# academic achievement by freetime
# 1 - very low to 5 - very high
boxplot(G3~freetime, boxwex = 0.5, col = c("yellow","green","blue","grey","red") , main="G3 by freetime")
# academic achievement by studytime
# 1 - <2 hour, 2 - 2 to 5 hours, 3 - 5 to 10 hours, 4 - >10hours
boxplot(G3~studytime, boxwex = 0.5, col = c("yellow","blue","grey","red"), main="G3 by studytime")
# 1) 방과후 자유시간에 따른 G3 차이 : 자유시간이 적은편(low)이라고 응답한 학생들 성적이 다소 높은데..
# 특별히 해석하기는 어렵다.
# 주중공부시간이 5시간이상 (3: 5-10시간, 4: 10시간 이상)인 학생들의 성적이 높은편임

# 3. xyplot : lattice package
# 통학시간과 최종성적(G3)의 멀티패널 그림(성별): lattice 패키지 사용
library(lattice)
xyplot(G3 ~ traveltime | sex , data = stud, pch=16, main = "G3 ~ traveltime | sex ")
# 1) 학생들 대부분은 30분 이내의 통학거리에 있으며,
# 2) 통학거리가 짧은 학생의 성적평균이 다소 높게 나타남.
# 3) 통학거리가 1시간 이상은 표본이 상대적으로 적음.
# 0점이 데이터 확인, 점검 필요

# data (G3=0)
# G3=0점인 데이터 (n=38명)
s1<-subset(stud, G3==0)
#ggplot(data=s1, aes(factor(s1$address)))+geom_bar(aes(fill=factor(s1$sex)), width=.4, colour="black")+ggtitle("G3=0")
#ggplot(data=s1, aes(factor(s1$internet)))+geom_bar(aes(fill=factor(s1$sex)), width=.4, colour="black")+ggtitle("G3=0")

# 4. scatterplot : ggplot2 package
# 산점도 (ggplot2패키지의 ggplot 사용)
library(ggplot2)
# scatterplot for G1 and G3 by sex
ggplot(stud, aes(x=G1, y=G3, color=sex, shape=sex)) + 
    geom_point(size=2)
# 성별에 따른 차이는 없다.

# 5. bar chart : ggplot2 package
# 막대그림
# bar chart for romantic by sex
ggplot(data=stud, aes(factor(romantic)))+geom_bar(aes(fill=factor(sex)), width=.4, colour="black")+ ggtitle("Romantic by sex")
# 연애경험이 있는 경우 여학생의 비율이 높다
# bar chart for internet use by (Urban, Rural)
ggplot(data=stud, aes(factor(internet)))+geom_bar(aes(fill=factor(address)), width=.4, colour="black")+ggtitle("Internet use by (Urban, Rural)")
# 인터넷 사용자 중에는 도심지역 거주자가 많다

# 6. pariwise plot
# pairwise scatterplot : pairs(변수리스트)
# new variable lists
vars1<-c("G1", "G2", "G3")
# pariwise plot
pairs (stud[vars1], main = "Student Math Data",
       pch = 21,bg = c ("red","green3")[unclass(stud$sex)])
# G1, G2, G3간의 상관성은 매우 높다
# 성별 간 차이는 없다

