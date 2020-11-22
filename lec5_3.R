# lec5_3.r
# 3D-plot, Heatmap

# set working directory
setwd("D:/tempstore/moocr")

# install 3d scatterplot package
install.packages('scatterplot3d')
library(scatterplot3d)

# 5-3 3D scatterplot with data trees
# 3D scatterplot : scatterplot(데이터$변수, pch= ~)
data(trees)

par(mfrow = c(1, 1))
s3d <- scatterplot3d(trees, type="h", highlight.3d=TRUE,
                     angle=55, scale.y=0.7, pch=16, main="scatterplot3d - 5")

# to know about data "trees" 데티터 점검하기
# 데이터 trees에 관하여 : help, head, write.table..
# trees 데이터
# Girth : 체리나무의 지름(inch), Height : 체리나무의 키 (feet)
# Volume : 나무의 부피(ft^3) - 나무의 둘레(x1)와 키(x2)로 목재의 부피(y)를 예측
# y = f(x1,x2)
help(trees)
head(trees)
# export to csv file
write.csv(trees,file="trees.csv", row.names = FALSE)

# 3D 산점도에 선형식 추가하기
# Now adding some points to the "scatterplot3d"
#s3d$points3d(seq(10,20,2), seq(85,60,-5), seq(60,10,-10),col="blue", type="h", pch=16)

# Now adding a regression plane to the "scatterplot3d"
# 1. 산점도를 s3d(이름은 자유지정)로 저장하고,
# 2. s3d의 요소 중 plane3d에 lm(Volume ~ Girth + Height)의 선형식을 추가
# lm(linear model)
# lm(변수 ~ x변수 + x변수 +...)
# 여기서는 y변수(나무의 부피), x변수(나무의 지름, 키)
# -> 나무의 부피는 나무의 지름이 클수록, 나무의 키가 클수록 크다
attach(trees)
my.lm <- lm(Volume ~ Girth + Height)
s3d$plane3d(my.lm, lty.box = "solid")


#############
# heatmap   #
#############
# 히트맵 : 통계치를 구한 후 크기에 비례하여 그라데이션 색으로 표현한 시각화 기법
# 색상을 열의 온도를 연상하게 해서 열(heatmap)이라고 함

# heatmap 1 using autompg data
# automag 데이터의 상관계수를 이용한 히트맵
car<-read.csv("autompg.csv")
#head(car)
#dim(car)
attach(car)

par(mfrow=c(1, 1))
cor.x<-cor(car[,1:6])
heatmap(cor.x, symm=TRUE)

#상관행렬의 시각화 : 대각선에 위치한 변수들이 상관계수가 큰 것을 알 수 있음
# heatmap 2 using USArrests data

# Crime rate by US State (1973)
# 미국범죄율 데이터, 1973년
# Arrests per 100,000 residents for assault, murder, and rape 
# in each of the 50 US states in 1973

help(USArrests)
head(USArrests)

#변수 산 상관관계
cor(USArrests)
round(cor(USArrests), 2)

# subset excluding 3th variable UrbanPop
# matrix format for heatmap
# 히트맵은 matrix형태여야 가능하다.
# 4개변수들 중 Urbanpop(도심인구비율) 변수 제외
x  <- as.matrix(USArrests[, -3])
result <- heatmap(x, scale="column", Colv=NA, cexCol=1,
                  main="Violent Crime Rates by US State (1973)")
# 인구 십만명단 폭행, 살인, 성범죄 비율에 따른 히트맵:
# 범죄 비율이 높은 주부터 낮은 주를 표시(빨간색이 낮은 주)
row.names(USArrests)[result$rowInd[1:10]] #범죄 발생 낮은주
row.names(USArrests)[result$rowInd[35:50]] #범죄 발생 높은 주
