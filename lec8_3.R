# lec8_3.R
# 텍스트 마이닝
# 텍스트 마이닝은 웹페이지, 이메일, SNS 기록, 등 전자문서 파일로부터
# 특정 연관성(동시적으로 빈도가 높은 단어추출)을 분석하는 방법
# 텍스트마이닝은 다양한 방식의 알고리즘을 이용하여 대용량의 
# 텍스트로부터 트렌드와 관심어를 찾아내는 기법으로 사요
# Install package NLP, tm, wordcloud

# set working directory
setwd("D:/tempstore/moocr")

# Natural language processing
install.packages('NLP')
# text mining package
install.packages('tm')
# visualizing
install.packages('wordcloud')
# color displaying
install.packages('RColorBrewer')

# set library (set in order)
library(NLP)
library(tm)
library(RColorBrewer)
library(wordcloud)

# 예제 데이터: crude 데이터 (로이터 통신의 20개의 뉴스기사)
# crude[[1]]: 첫 번째 기사 (xml파일형태), tm패키지에 들어있는 예제 데이터
# 20 new articles from Reuter- 21578 data set
data(crude)
# To know abour crude data
help(crude)

# remove punctuation in documnet
crude<-tm_map(crude, removePunctuation)
# remove stopwords
crude<-tm_map(crude, removeNumbers)
crude<-tm_map(crude, function(x) removeWords(x,stopwords()))
stopwords()

# from frequency counts
tdm<-TermDocumentMatrix(crude)
m<-as.matrix(tdm)
v<-sort(rowSums(m), decreasing=TRUE)
d<-data.frame(word=names(v), freq=v)

# plot a word cloud
# to see detail help(wordcloud) 
par(mfrow=c(1, 1))
wordcloud(d$word, d$freq, random.order=FALSE)

