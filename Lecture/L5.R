setwd("/Users/noahhorowitz/git_repositories/SMU-DDS-HW/Lecture")
data1 <- read.table('case0102.csv', sep=',', header = TRUE)
head(data1)
library(repmis)
library(RCurl)
site <- 'http://www.users.miamioh.edu/hughesmr/sta333/baseballsalaries.txt'
download.file(site, destfile = 'baseballsalaries.txt')
list.files()
#grep('^[Ii]$', file)
#grep('[0-9]')
#grep('[9.11]') #single wildcard
#grep('item+ (.*) [0-9]', file) # * any number of item # + at least one of item

#grep('[flood|fire|friend]') #or]
library('dplyr')
library('tidyr')
library('jsonlite')
library('WDI')
FertConsumpData <- WDI(indicator = "AG.CON.FERT.ZS")
str(FertConsumpData)
SpreadFert <- spread(FertConsumpData, year,  AG.CON.FERT.ZS)
head(SpreadFert)
Spreadfert <- arrange(SpreadFert, country)
head(Spreadfert)
GatheredFert <- gather(Spreadfert, Year, fert, 3:9)
head(GatheredFert)
str(GatheredFert)
GatheredFert <- rename(GatheredFert, fert_con = fert)
str(GatheredFert)

ggplot(GatheredFert, aes(fert_con)) + geom_density()

FertOutliers <- subset(GatheredFert, fert_con > 1000)
GatheredFertSub <- subset(GatheredFert, fert_con <= 1000)
GatheredFertSub <- subset(GatheredFertSub, country != 'Arab World', !is.na(fert_con))
ggplot(GatheredFertSub, aes(fert_con)) + geom_density()





