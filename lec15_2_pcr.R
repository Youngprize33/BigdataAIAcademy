# lec15_2_pcr.r
# Multivariate analysis
# Principle Component regression
# 주성분분석의 순서
# 1. 데이터에 다중공선성이 있는지 체크
# 2. 주성분 분석을 하기 위한 데이터 전처리(mean-centering or scaling)
# 3. 주성분 분석
# 4. 주성분 개수 결정
# 5. 주성분으로 회귀 분석모형 수행

# 특징
# 여러 변수들을 주성분이라는 새로운 변수로 축소하여 회귀모형 수행
# 다중공선성 문제 해결 가능
# 적절한 주성분을 사용하여 회귀모형 구현 필요
# 항상 주성분의 순서대로 Y변수에 대한 설명력이 높은 것은 아님

# set working directory
setwd("D:/tempstore/moocr/wk15")

# wine data
wine<-read.csv(file="wine_aroma.csv")
attach(wine)
head(wine)

# Check correlation
cor(wine[1:9])

# 1. PCA(center=T->mean=0, scale.=T->variance=1)
wi.pca<-prcomp(wine[1:9],center=T,scale.=F)
# wi.pca<-prcomp(wine[1:9],center=T,scale.=T)
wi.pca
summary(wi.pca)

# wi.pca is the weight to get 1st-8th principal compoenents 

# 2.scree plot : to choose the number of components
plot(wi.pca,type="l")

# 3. calculate component=x_data%*% PCA weight
PRC<-as.matrix(wine[,1:9])%*%wi.pca$rotation
head(PRC)

# 4. Principal component regression
# make data with components
wine.pc<-cbind(as.data.frame(PRC),Aroma)
head(wine.pc)

# regression(PC1-PC4)
# 결과값을 보았을때, X의 분산을 가장 잘 설명하는 주성분이
# Y를 항상 가장 잘 설명해주지 않는다는 것을 알 수 있다.
fit1<-lm(Aroma~PC1+PC2+PC3+PC4, data=wine.pc)
fit1
summary(fit1)

# regression(PC1-PC9)
fit2<-lm(Aroma~., data=wine.pc)
fit2
summary(fit2)

# residual diagnostic plot
layout(matrix(c(1,2,3,4),2,2)) # optional 4 graphs/page 
plot(fit2)

# Multiple regression with the raw data
fit3<-lm(Aroma ~., data=wine)
summary(fit3)

# residual diagnostic plot 
layout(matrix(c(1,2,3,4),2,2)) # optional 4 graphs/page 
plot(fit3)

#measuring accuracy
# fit1_pred<-predict(fit1,newdata=wine.pc)


