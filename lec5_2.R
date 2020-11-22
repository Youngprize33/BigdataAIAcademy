# lec5_2.r
# Grapic using ggplot2 

#########STEP0 : 분석을 위한 설정(library, package, setwd)######
# set working directory
setwd("D:/tempstore/moocr")

# library
install.packages('ggplot2')
library(ggplot2)

#########STEP1: 데이터 핸들링(불러들이기, subset, 변수값정의)#####
# Read in R : autompg data
car<-read.csv("autompg.csv")
head(car)
str(car)

# subset of car : cyl (4,6,8)
car1<-subset(car, cyl==4 | cyl==6 | cyl==8)
attach(car1)

##########STEP2: 데이터 탐색(그래픽) #####
# 5-1 ggplot2 for scatterplot 
# Color and shape display by factor (categorical variable)
# check the variable type(integer, numeric, factor) and define it
str(car1)
car1$cyl<-as.factor(car1$cyl)

# Now, you can draw one of plot using ggplot
# x축에는 차의무게, y푹에는 배기량의 산점도, 점의 색상은 실린더 수
# geom_point는 숫자가 클수록 점 크기가 커진다.
par(mfrow = c(1, 1))
ggplot(car1, aes(x=wt, y=disp, color=cyl, shape=cyl)) + 
  geom_point(size=3, alpha=0.6)

# mapping (continuous variable : mpg) on the scatterplot for wt and disp
# 차의 무게와 배기량의 산점도에 연비의 높고 낮음을 원의 사이즈와 색으로 표시
ggplot(car1, aes(x=wt, y=disp, color=mpg, size=mpg)) + 
  geom_point(alpha=0.6)

# 5-2-1 : geom_bar : asethetic mapping (4,6,8 cyl)
# grid를 그림-cyl에 따라서
p1<-ggplot(car1, aes(factor(cyl), fill=factor(cyl)))
p1
# barplot define
# geom_bar을 이용해 cyl빈도의 막대그래프
p1<-p1 + geom_bar(width=.5)
p1
# output by origin(1,2,3)
# cyl의 barchart를 변수 origin에 따라 그림
p1<-p1 + facet_grid(. ~ origin)
p1
# 5-2-1 : same plot with the above
ggplot(car1, aes(factor(cyl), fill=factor(cyl)))+ geom_bar(width=.5)+ facet_grid(. ~ origin)


# 5-2-2 : geom_bar : asethetic mapping (4,6,8 cyl)
# geom_bar을 이용한 누적 막대그래프
p <- ggplot(data=car1, aes(factor(cyl)))
p + geom_bar(aes(fill=factor(origin)), colour="black")

# for Korean title
# 5-2-2 : geom_bar : asethetic mapping (4,6,8 cyl)
par(family="나눔고딕", cex=1.3)
p <- ggplot(data=car1, aes(factor(cyl)))
p<-p + geom_bar(aes(fill=factor(origin)), colour="black")
p<-p+ggtitle("자동차데이터")
p


# 5-3 ggplots for scatterplot with regression line
#산점도에 회귀선 넣기
# step1 : # Use hollow circles
#autpmpg 데이터 사용 : 차량무게에 따른 연비예측 
ggplot(car1, aes(x=wt, y=mpg))+geom_point(shape=1)

# step2 :  # Add linear regression line 
# by default includes 95% confidence region
ggplot(car1, aes(x=wt, y=mpg)) + geom_point(shape=1) + geom_smooth(method=lm)  

# excluding 95% confidence region
# 신뢰구간이 없는 회귀선 그리기
ggplot(car1, aes(x=wt, y=mpg)) +
  geom_point(shape=1) +  geom_smooth(method=lm, se=FALSE) 

# step3: Add a loess smoothed fit curve with confidence region
# geom_smooth() use loess 
# ggplot 산점도에 비선형회귀식 loess(local plynomial regression)
ggplot(car1, aes(x=wt, y=mpg)) + geom_point(shape=1) + geom_smooth(method="loess") 


#ggplot의 기본
#ggplot : 새로운 ggplot을 생성
#aes : aesthetic mapping을 구성(데이터, 그래프구조)
#qplot : 즉석 그림

#geom 함수군 (geometric 함수군)
#geom_abline, geom_hline, geom_vline
#geom_bar, geom_point, geom_boxplot, geom_map, geom_smooth, stat_smooth

