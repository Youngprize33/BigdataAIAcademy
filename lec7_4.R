# lec7_4.r
# 이원분산분석 (factor가 2개인 분산분석)
# two-way ANOVA

# set working directory
setwd("D:/tempstore/moocr")

# 데이터 : High-Density Lipoprotein (HDL) 콜레스테롤, HDL(고밀도 리포 단백질)은 높을수록 좋고 40mg이상이 정상범위
# chol_ex.csv - 1.ID 2.drug: 5mg, 10mg, placebo 3.age:young(18-39), old(>=40)
#               4.value: HDL(투약전)-HDL(투약후) | 차이, 뺀거임
# data(chol_ex.csv) : A study was performed to test the efficiency of a new drug developed 
# to increase high-density lipoprotein (HDL) cholesterol levels in patients. 
# 18 volunteers were split into 3 groups (Placebo/5 mg/10 mg) and 
# the difference in HDL levels before and after the treatment was measured. 
# The 18 volunteers were also categorized into two age groups (18-39/ ??40)
# 이원분산분석(two-way ANOVA): factor가 두 개인 경우
# 1) 투약효과가 있는가? (5mg, 10mg, 위약)
# 2) 연령그룹(young/ old)에 따른 영향이 있는가?ㅇ
# 가설1: 신약의 투약효과가 있는가? HDL을 상승시키는 효과가 있는가?
# 가설2: 연령그룹에 따라 투약효과(HDL변화)에 차이가 있나?
# 가설3: 신약의 투약과 연령그룹간 상호작용 효과가 있는가?

# 이원분산분석: aov(타겟변수~factor1+factor2)

dat<-read.csv(file="chol_ex.csv")
head(dat)
dim(dat)
str(dat)
attach(dat)

# two-way ANOVA, 
a6 <- aov(value ~ drug + age)
summary(a6)
# 1)drug effect: p-value~0이므로 HDL값에 통계적으로 유의한 차이가 있음
# 2)age: p-value=0.19로 유의수준 0.05에서 유의한 차이는 없음

# two-way ANOVA with interaction
# 두개의 factor간 상호작용의 유의성을 검정하기 위한 분석
a7 <- aov(value ~ drug + age+ drug*age)
summary(a7)
# 3)drug와 age그룹간 상호작용: p-value=0.286으로 유의수준 0.05에서 유의한 차이는 없음

# post-hoc analysis Tukey
posthoc <- TukeyHSD(a6, 'drug', conf.level=0.95)
posthoc

# two-way ANOVA
# 투약용량과 연령그룹에 따른 상자그림
par(mfrow=c(1,2))
boxplot(value ~ drug, boxwex = 0.7, main="HDL by drug dose", col = c("yellow","orange", "green"))
boxplot(value ~ age, boxwex = 0.5, main="HDL by Age", col = c("blue", "coral"))

# tapply - give FUN value by drug
round(tapply(value, drug, mean),2)
# drug effect: 10mg인 경우 HDL 상승효과가 가장 높음 

# tapply - give FUN value by age
round(tapply(value, age, mean),2)
# age: young그룹(18-40)의 HDL 상승효과가 더 높음

# interaction plot
# 상호작용 그래프
par(mfrow=c(1,2))
interaction.plot(drug, age, value) #투약용량을 기준(x축)으로 그릴때
interaction.plot(age, drug, value) #연령그룹을 기준(x축)으로 그릴때
# 투약용량 10mg에서 young그룹의 상승효과가 old그룹에 비해서 훨씬 높음
# 5mg에서와 placebo에서는 연령그룹의 차이가 거의 없음

# Create an interaction plot for the HDL data
par(mfrow=c(1,2))
interaction.plot(dat$drug, dat$age, dat$value)
interaction.plot(dat$age, dat$drug, dat$value)

# two-way ANOVA model with interaction
results = lm(value ~ drug + age + drug*age, data=dat)
anova(results)
