# lec14_1_ass.r
# Association Rule
# Market basket analysis
# 신뢰도는 조건부확률

# set working directory
setwd("D:/tempstore/moocr/wk14")

# 연관규칙 수행을 위한 패키지
# association rule analysis package
install.packages("arules")
library(arules)

# data import-> make transaction data
dvd1<-read.csv("dvdtrans.csv")
dvd1
dvd.list<-split(dvd1$Item,dvd1$ID)
dvd.list
dvd.trans<-as(dvd.list,"transactions")
dvd.trans

inspect(dvd.trans)

# summary of dvd.trans
summary(dvd.trans)

# for running dvdtras data
dvd_rule<-apriori(dvd.trans,
                  parameter = list(support=0.2,confidence = 0.20,minlen = 2))
dvd_rule

# same code with short command
# dvd_rule<-apriori(dvd.trans, parameter = list(supp=0.2,conf= 0.20,minlen = 2))                             

#연관규칙 수행 콘솔창
summary(dvd_rule)
#연관규칙수행결과
inspect(dvd_rule)

# Bar chart for support>0.2
itemFrequencyPlot(dvd.trans,support=0.2,main="item for support>=0.2", col="green")



