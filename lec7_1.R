# lec7_1.r 
# 두 그룹 간 평균비교
# t-test for two sample means

# set working directory
setwd("D:/tempstore/moocr")

### student math grade data ####
stud<-read.csv("stud_math.csv")

head(stud)
dim(stud)
str(stud)

attach(stud)

# 1. single t-test : to test whether or not mean of G3 is 10
#단일표본 평균검정: t.test(변수, mu= 검정하고자 하는 평균값)
#가설1: G3(최종성적) 평균이 10인가?

t.test(G3, mu=10)

# 2. two sample t-test
## example 1 
# to test whether or not mean of G3 is same between Urban and Rural
# 두집단 표본평균 비교검정 : t.test(종속변수(타겟변수)~범주형변수, data= )
#가설2 : 거주지역(R,u)에 따른 G3(최종성적) 평균에 차이가 있는가?
t.test(G3~address, data=stud)
boxplot(G3~address, boxwex = 0.5, col = c("yellow", "coral"))

# alternative H : mu(Rural)< mu(Urban)
# 두집단 표본평균 비교검정(단측검정) : t.test(연속변수 ~ 범주형변수, data= )
t.test(G3~address, data=stud, alternative = c("less"))

help(t.test)

## example 2 
# to test whether or not mean of G3 is equal for activities 
# 가설3 : 방과후 활동여부(yes,no)에 따른 G3(최종성적) 평균에 차이가 있는가?
t.test(G3~activities, data=stud)
boxplot(G3~activities, boxwex = 0.5, col = c("blue", "red")) #그래픽으로도 유추 가능


# 3. Non-parametric method
# Wilcoxon signed-rank test
# 비모수는 특정한 분포를 갖고 있지 않을 때 검정하는 방법
# 두 집단의 비모수적 방법 : (Wilcoxon rank sum Test) : wilcox.test(x,y)
# wilcox.test는 타겟변수가 등간척도(통증정도, 만족도, ...)일때 사용할 수 있다.
# wilcox.test(타겟변수~범주형변수) | 두 집단이 독립적일 때 사용 가능
# wilcox.test(G3, mu=10)
wilcox.test(G3~address)
help(wilcox.test)

