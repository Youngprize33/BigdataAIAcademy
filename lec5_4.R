# lec5_4.R
# 지역의 행정자료 (인구자료 등)를 지도에 그릴 때

# maps : world map
# 세계지도
install.packages("maps")
library(maps)

# mapdata : more world map
# maps보다 정교한 지도
install.packages("mapdata")
library(mapdata)

# mapdata : latitude and longitude
# 위도와 경도
install.packages("mapproj")
library(mapproj)

# maps() : 지도를 시각화
# map.text
# map.cities() : 시각화된 지도위에 도시이름 출력
# map.axes() : 위도, 경도 축을 그려줌

# 한국지도 : maps와 mapdata를 이용한 지도
# Korea using map package
par(mfrow = c(1, 2), mar=c(2,2,2,2))
map(database = 'world', region = c('South Korea', 'North Korea'))
title("Korea : maps packages")

# Korea using mapdata package
map(database = 'worldHires', region = c('South Korea', 'North Korea'))
title("Korea : mapdata packages")
#이게 조금 더 정확하게 나오고 있으을 알 수 있다.

#중국의 3대 대도시 (인구가 3백5십만-5백만) : maps패키지
# China with large city
par(mfrow = c(1, 1), mar=c(2,2,2,2))
map("worldHires", "China")
map.cities(country = "China", capitals = 3, minpop = 3500000, maxpop = 5000000)
title("capitals=3, minpop=3500000, maxpop=5000000")

#mapdata패키지 : maps패키지가 갖고있는 지도보다 해상도가 좋
# 'worldHires' 지도 데이터베이스가 포함됨
# world database: a cleanep-up version of the CIA World Data Bank II data

#주변 아시아 국가지도 : mapdat 패키지를 이용한 지도
# Using mapdata package
# Korea, Japan, China (Textbook : R Visualization)
par(mfrow = c(1, 1), mar=c(2,2,2,2))
map('worldHires', region=c('South Korea', 'North Korea', 'Japan', 'China'))
map('worldHires', region=c('South Korea'), col = 'blue', add = TRUE, fill = TRUE)
map('worldHires', region=c('North Korea'), col = 'coral', add = TRUE, fill = TRUE)
map('worldHires', region=c('Japan'), col = 'grey',add = TRUE, fill = TRUE)
map('worldHires', region=c('China'), col = 'yellow',add = TRUE, fill = TRUE)

# 독도표시 ( mapproj 패키지 활용 - 위도 경도 표시)
# Dokdo map using mapproj package
library(mapproj)

# for reading Korean : encoding to UTF-8 
# file menu: Tools_global options_code_saving
map('worldHires', proj = 'azequalarea', orient = c(37.24223, 131.8643, 0))
map.grid(col = 2)
points(mapproject(list(y = 37.24223, x = 131.8643)), col = "blue", pch = "x", cex = 2)
title("독도")

# 지도 데이터베이스와 행정자료 결합 : 미국(1973) 범죄수 지도
# Assault in US (1973)
par(mfrow = c(1, 1), mar=c(1,1,1,1))
# library(maps)
# excluding Alaska, Hawaii 
sub.usa <- subset(USArrests,!rownames(USArrests) %in% c("Alaska", "Hawaii"))
# data with State name, Assult count
usa.data <- data.frame(states = rownames(sub.usa), Assault = sub.usa$Assault)
# legend
col.level <- cut(sub.usa[, 2], c(0, 100, 150, 200, 250, 300, 350))
legends <- levels(col.level)
# displaying color for the size  
levels(col.level) <- sort(heat.colors(6), decreasing = TRUE)
usa.data <- data.frame(usa.data, col.level = col.level)
# Map 
map('state', region = usa.data$states, fill = TRUE, col = as.character(usa.data$col.level))
title("USA Assault map")
legend(-77, 34, legends, fill = sort(heat.colors(6), decreasing = TRUE), cex = 0.7)

help(USArrests)
head(USArrests)

## extra practice : Italy
op <- par(no.readonly=TRUE)
par(mfrow=c(2, 2), mar=c(0, 0, 1, 0))
map("italy")
title("databse=\"italy\"")
map("italy", fill=TRUE, col=2:4)
title("fill=T, col=2:4")
map("italy", resolution=5)
title("resolution=5")
map("italy")
map("italy", "a", exact=FALSE, fill=TRUE, col="red", add=TRUE, lwd=3)
title("exact=F, add=T, lwd=5")
par(op)


######################################################
# color
# 1 black   2 red   3 green   4 blue   5 cyan   6 magenta   7 yellow   8 gray
####################################################
par(mfrow=c(1, 1))
barplot(rep(1,8), yaxt="n", col=1:10)
# see all color (657 colors)
colors()
# see rgb values for 657 colors
col2rgb(colors()) 
# make table of colors and the corresponding RGB
cc1<-cbind(colors(), t(col2rgb(colors()))) 

# select colors including "cyan" 
colors()[grep("cyan", colors())]

colors()[grep("sky", colors())]
