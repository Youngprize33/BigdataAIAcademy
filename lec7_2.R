# lec7_2.r 
# 짝을 이룬 그룹간 비교(paired t-test)
# 두 집단이 독립이 아닐 때
# paired t-test for two sample means
# 특정 처리(treatment)의 효과를 비교분석할 때 사용
# 동일한 실험표본 : before & after 측정
# 예제 : 1) 혈압강하제의 투약효과
#        2) 방과후프로그램의 성과 (학업흥미도)
#        3) 다이어트 프로그램의 효과
#        4) 직무교육후의 생산성 향상의 효과

# set working directory
setwd("D:/tempstore/moocr")

## example 1: blood pressure data
#예제1: 고혈압 환자 10명에게 혈압강하제를 12주 동안 투여한 후 복용전의 혈압과 복용 후의 혈압을
#       비교하였다. 새로운 혈압강하제가 효과가 있을까?
#짝을 이룬 그룹간 비교 : paired t-test : t.test(before,after,mu=0,paired=T)
bp<-read.csv("bp.csv") 
attach(bp)

# 귀무가설은 (difference의 평균이) 차이가 없다, 대립가설을 차이가 있다.
# paired t-test (two-sided)
t.test(bp_pre, bp_post, mu=0,  paired=T)

# paired t-test (one-sided)
# 혈압(투약전, 투약후)의 차이가 0보다 큰가?
t.test(bp_pre, bp_post, mu=0, alternative="greater", paired=T)

# paired t-test (two-sided, 90% confidence inte횩효고rval)
t.test(bp_pre, bp_post, mu=0, alternative="two.sided", paired=T, conf.level=.90)푭표보

## example 2: Very Low-calroie diet 
# 예제2: 비만 대상자들(성인)에게 12주 동안 극저 칼로리 식이요법(very low-calorie diet:VLCD)
# 을 실시한 후 그 효과를 비교하였다. 이 프로그램이 체중 감소에 효과가 있다고횩효고과 할 수 있는가?
# 즉, 극저 칼로리 식이요법(very low-calorie diet:VLCD)의 효과
diet<-read.csv("weight.csv") 
attach(diet)

# paired t-test (default=two-sided, 95% confidence interval)
t.test(wt_pre, wt_post, mu=0,  paired=T)

# to get 90% confidence interval in paired t-test
t.test(wt_pre, wt_post, mu=0, alternative="two.sided", paired=T, conf.level=.90)








