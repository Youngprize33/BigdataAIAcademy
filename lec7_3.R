# lec7_3.r 
# ANOVA(분산분석) - ANalysis Of VAriance
# 분산이 어디(어떤요인)에서 나왔는지 찾아가는 것
# ANOVA : 전체분산(Variance)의 분할(분석, analysis)하여 어떤 요인(factor)의 영향이
# 유의(significant)한지 검정하는 방법.

# set working directory
setwd("D:/tempstore/moocr")

### student math grade data ####
stud<-read.csv("stud_math.csv")

head(stud)
dim(stud)
str(stud)

attach(stud)

# boxplot in lec6_3.R 
par(mfrow=c(1,2))
boxplot(G3~address, boxwex = 0.5, col = c("yellow", "coral"), main="G3 by (Urban, Rural)")
boxplot(G3~traveltime, boxwex = 0.5, col = c("red","orange","yellow","green"), main="G3 by traveltime")
# 도심지역의 학생들 성적이 외곽지역 학생들보다 더 높다.
# 통학시간이 짧(15분이내)의 학생들의 성적이 더 높다.

# 1. ANOVA by address 
# 거주지역에 따른 학업성취도 : 거주지역(factor: R/U), 학업성적(1-20)
# 가설1: 거주지역(R/U)에 따라 G3에 유의한 영향이 있나?
# aov(타겟변수~factor)
a1 <- aov(G3~address)
summary(a1)
# tapply - give FUN value by address
round(tapply(G3, address, mean),2)

# post-hoc analysis after ANOVA
#posthoc <- TukeyHSD(x=a1, 'address', conf.level=0.95)
#plot(posthoc)

# 2. ANOVA by traveltime 
# 통학시에 따른 학업성취도 : 통학시간(factor: 1-4), 학업성적(1-20)
# 가설2: 통학시간에 따라 G3에는 유의한 차이가 있는가?
traveltime<-as.factor(traveltime)
a2 <- aov(G3~traveltime)
summary(a2)

# tapply - give FUN value by address
round(tapply(G3, traveltime, mean),2)

# should be foctor for Tukey's Honest Significant Difference test
# 사후검정 : ANOVA에서 어떤 factor의 유의성이 검정되면, 그 다음단계에 하는 검정
# Tukey's Honest Significant Difference Test
TukeyHSD(a2, "traveltime", ordered=TRUE)
plot(TukeyHSD(a2, "traveltime"))

# 4. ANOVA by romantic 
# 연애경험여부에 따른 학업성취도: 연애경험(yes,no), 학업성적(1-20)
a4 <- aov(G3~romantic)
summary(a4)
# 연애경험이 있는 경우 유의미하게 낮다. 
# boxplot을 보았을 때, median은 비슷해보이나, 평균은 차이 있음
# tapply - give FUN value by address
round(tapply(G3,romantic, mean),2)
# boxplot
boxplot(G3~romantic, boxwex = 0.5, col = c("yellow", "coral"), main="G3 by romantic")
# posthoc analysis
TukeyHSD(a4, "romantic", ordered=TRUE)
plot(TukeyHSD(a4, "romantic"))


 
