# lec6_4.r
# 데이터의 정규성 검정과 신뢰구간
# Normality test, confidence interval

# set working directory
setwd("D:/tempstore/moocr")

### student math grade data ####

stud<-read.csv("stud_math.csv")

head(stud)
dim(stud)
str(stud)

attach(stud)

# 1-2 Testing for normality
# 정규확률도 (Normal Q-Q plot) : 데이터가 정규분포하는가?
# multiple plot (2 by 2)
par(mfrow=c(2,2))
#Quantile plot
qqnorm(G1)
qqline(G1, col = 2, cex=7)
# QQline의 티폴트는 정규분포의 1사분위, 3사분위를 직
# qqline(y, distribution = qqnorm, probs = c(0.25,0.75))

qqnorm(G2)
qqline(G2, col = 2, cex=7)

qqnorm(G3)
qqline(G3, col = 2, cex=7)

# 정규분포 적합성 검정 : 데이터가 정규분포 하는지에 대한 검정
#Shapiro-Wilks test
#추가패키지 필요없
#귀무가설이 정규분포이다
shapiro.test(G3)

#ks.test(G3, "pgamma",3,2)

#Anderson-Darling test require installing package "nortest"
#귀무가설이 정규분포이다
install.packages('nortest')
library(nortest)
ad.test(G3)

# data simulation
# Simulation examples
#p:누적함수, d:확률밀도함수, q:quantile함수, r: 랜덤넘버의 생성
#확률분포함수로부터 데이터 생성
runif(5,min=1,max=5)
rnorm(5,mean=5,sd=1)
rgamma(5,shape=3,rate=2)
rbinom(5,size=100,prob=.2)

# from normal distribution
# 정규분포에서 데이터 생성, 밀도함수 그래프 그리기
x<-rnorm(1000)
plot(density(x),xlim=c(-5,10))

# confidence interval of normal distribution
# 데이터생성 (정규분포(평균=500,편차=100)) 100개 데이터 생성
nreps <- 100
ll <- numeric(nreps)
ul <- numeric(nreps)
n <- 100
mu <- 500
sigma <- 100
for(i in 1:nreps) {
  set.seed(i)
  x <- rnorm(n, mu, sigma)
  ll[i] <- mean(x) - qnorm(0.975)*sqrt(sigma^2/n)
  ul[i] <- mean(x) + qnorm(0.975)*sqrt(sigma^2/n)
}

# Draw 95% confidence interval
par(mfrow=c(1,1))
plot(1:100, ylim=c(min(ll), max(ul)),
     ylab="95% Confidence Interval", xlab="iterations")

for(i in 1:100) lines(c(i, i), c(ll[i], ul[i]))
abline(h=mu, col="red", lty=2, lwd=3)

#신뢰구간의 정의
#신뢰구간은 실제 모수(parameter = 모평균, 모분산 등)를 추정하는데
#몇 퍼센트의 확률로 그 신뢰구간이 실제 모수를 포함하게 될 것이냐 하는 것이다.
#예를 들어 모평균(m,뮤)의 추정을 위해 100번의 sampling을 통해 표본평균과 표본분산을 구하여
#100개의 신뢰구간을 얻었을 때, 그 100개의 신뢰구간 중 95개에
#모평균(m,뮤)이 포함되게 설정된 신뢰구간을 95%신뢰구간이라 한다.
