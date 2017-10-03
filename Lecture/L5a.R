URL <- 'http://bit.ly/1jXJgDh'
temp <- tempfile()
download.file(URL, temp)
file.mtime(temp) #outputs date and time
UDSData <- read.csv(gzfile(temp, 'uds_summary.csv'))
dim(UDSData) #outputs dimensions
names(UDSData) #outputs column names
str(UDSData) #outputs col var types
unlink(temp)

library(downloader)
download('https://raw.githubusercontent.com/thoughtfulbloke/faoexample/master/appleorange.csv', destfile = 'appleorange.csv')
download('https://raw.githubusercontent.com/thoughtfulbloke/faoexample/master/stability.csv', destfile = 'stability.csv')
list.files()

ao.raw <- read.csv('appleorange.csv', stringsAsFactors = FALSE, header = FALSE)
head(ao.raw, 10)
str(ao.raw)

ao.data <- ao.raw[3:700,]
names(ao.data) <- c('country', 'countrynumber', 'products', 'productnumber', 'tonnes', 'year')
ao.data$countrynumber <- as.integer(ao.data$countrynumber)

fslines <- which(ao.data$country == 'Food supply quantity (tonnes) (tonnes)')
ao.data <- ao.data[(-1*fslines),]

ao.data$tonnes <- gsub('\xca', '', ao.data$tonnes)
ao.data$tonnes <- gsub(', tonnes \\(\\)', '', ao.data$tonnes)
ao.data$tonnes <- as.numeric(ao.data$tonnes)
ao.data$year <- 2009

apples <- ao.data[ao.data$productnumber==2617, c(1,2,5)]
names(apples)[3] <- 'apples'

oranges <- ao.data[ao.data$productnumber==2611, c(2,5)]
names(oranges)[2] <- 'oranges'

ao.clean <- merge(apples,oranges, by = 'countrynumber', all=TRUE)

ao.clean.2 <- dcast()