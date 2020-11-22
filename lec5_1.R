#lec5_1.r 
# lattice, ggplot2 packages

# set working directory
setwd("D:/tempstore/moocr")

###################################
# install lattice
####################################
#lattice는 여러 개 그래프를 가로, 세로 배열로 비교분석
#주로 다변량 데이터의 변수간 관계 혹은 특징을 파악하는데 유용
#xyplot, bwplot, dotplot, levelplot, stripplot, splom, contourplot 사용가능
#xyplot : 산점도, bwplot: 상자그림, stripplot : 점을 함께 표시한 상자그림
#splom : 산점도 매트릭스, #contourplot : 등고선그림


install.packages('lattice')
library(lattice)

# to see several plot using lattice pacakge
demo(lattice)

# to see lattice manual
help(lattice)

# ethanol data in lattice #에탄올 데이터 사용 가능
help("ethanol")

# checking ethanol data
head(ethanol)
dim(ethanol)
str(ethanol)

table(ethanol$C) #C변수의 빈도 파악 가능

# basic xyplot #기본 산점도와 동일함
xyplot(NOx ~ E , data = ethanol, main = "Single Panel by xyplot")

# multi panel graph (y변수~x변수| 조건부변수, data=)
#여기서는 엔진압축비(C)가 조건부변수:
#공기와 연료의 혼합비(E)와 질소 산화도배출량(NOX)의 산점도
#엔진압축비 (7.5, 9, 12, 15, 18) 의 5가지 변수
xyplot(NOx ~ E | C , data = ethanol, main = "NOx ~ E | C ")

# multi panel graph for subset (subset데이터 활용해서 그리기)
xyplot(NOx ~ E | C , data = ethanol, subset = C > 8,
       main = "NOx ~ E | C , data = ethanol, subset = C > 8")

#R을 활용한 데이터 시각화
#www.r-grapgh-gallery.com/portfolio/ggplot2-package/
#www.cookbook-r.com/Graphs/
#ggplot.org ggplot2 공식 사이트
#docs.ggplot2.org 하위 옵션 사용법 및 예제
#groups.google.com/group/ggplot2




