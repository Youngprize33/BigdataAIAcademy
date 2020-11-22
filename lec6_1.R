# lec6_1.r 데이터 다루기 (data handling, data management)
# 데이터 결합, 분할, 정렬
# Data management : merge, sorting, subset 

# set working directory
setwd("D:/tempstore/moocr")

# practice data
dat1<-read.csv(file="data1.csv")
dat2<-read.csv(file="data2.csv")

# data merging
# 데이터 결합 
# data1과 data2는 아래와 같이 식별변수 ID를 기준으로 결합
# data1: 게임장르, 나이, 성별
# data2: 주당게임시간, 음주경험, 흡연경험
dat12<-merge(dat1, dat2, by="ID")

# add more data (combine in a row)
# data3과 data4가 동일한 변수들을 갖고 있을때 두개 데이터를
# 행(row)으로 결합
dat3<-read.csv(file="data3.csv")
dat123<-rbind(dat12, dat3)
dat123

# export to csv file
# write.csv(dat12,file="data12.csv", row.names = FALSE)

# data sorting
# 데이터 정렬: 데이터이름[order(변수1,변수2),]
dats1<-dat12[order(dat12$age),]
dats1
dats2<-dat12[order(dat12$gender, dat12$age), ]
dats2

# data subset (selecting data)
# 데이터 추출 - subset(데이터이름, 조건1&조건2)
#newdat<-dat12[which(dat12$gender=="F" & dat12$age>15),]
# dat12에서 gender = F이고 age>15이상인 데이터를 newdata라는 이름의 데이터로 저장
newdat<-subset(dat12, dat12$gender=="F" & dat12$age>15)
newdat

# excluding variables
# 데이터에서 일부변수 제거하기 - 데이터이름[!names(데이터) %in% c("변수1","변수2")]
# dat12에서 age와 gender를 제외하고 exdat라는 이름의 데이터로 저장(!는 not의미)
exdat<-dat12[!names(dat12) %in% c("age","gender")]
exdat


