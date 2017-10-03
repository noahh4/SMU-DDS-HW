# MSDS 6306 Tibbett 402 Week 5 HW
Noah Horowitz  
10/2/2017  



#1. Data Munging (30 points): Utilize yob2016.txt for this question. This file is a series of popular children’s names born in the year 2016 in the United States. It consists of three columns with a first name, a gender, and the amount of children given that name. However, the data is raw and will need cleaning to make it tidy and usable.

##A. First, import the .txt file into R so you can process it. Keep in mind this is not a CSV file. You might have to open the file to see what you’re dealing with. Assign the resulting data frame to an object, df, that consists of three columns with human-readable column names for each.

```r
setwd('/Users/noahhorowitz/git_repositories/SMU-DDS-HW/HW5')
df <- read.table('yob2016.txt', header = FALSE, sep = ';', col.names = c('First.Name', 'Sex', 'Frequency'))
```
##B. Display the summary and structure of df

```r
summary(df)
```

```
##    First.Name    Sex         Frequency      
##  Aalijah:    2   F:18758   Min.   :    5.0  
##  Aaliyan:    2   M:14111   1st Qu.:    7.0  
##  Aamari :    2             Median :   12.0  
##  Aarian :    2             Mean   :  110.7  
##  Aarin  :    2             3rd Qu.:   30.0  
##  Aaris  :    2             Max.   :19414.0  
##  (Other):32857
```

```r
str(df)
```

```
## 'data.frame':	32869 obs. of  3 variables:
##  $ First.Name: Factor w/ 30295 levels "Aaban","Aabha",..: 9317 22546 3770 26409 12019 20596 6185 339 9298 11222 ...
##  $ Sex       : Factor w/ 2 levels "F","M": 1 1 1 1 1 1 1 1 1 1 ...
##  $ Frequency : int  19414 19246 16237 16070 14722 14366 13030 11699 10926 10733 ...
```
##C. Your client tells you that there is a problem with the raw file. One name was entered twice and misspelled. The client cannot remember which name it is; there are thousands he saw! But he did mention he accidentally put three y’s at the end of the name. Write an R command to figure out which name it is and display it.

```r
row.yyy <- grep('yyy$', df$First.Name)
df[row.yyy,]
```

```
##     First.Name Sex Frequency
## 212   Fionayyy   F      1547
```
##D. Upon finding the misspelled name, please remove this particular observation, as the client says it’s redundant. Save the remaining dataset as an object: y2016


```r
y2016 <- df[-212,]
```

#2. Data Merging (30 points): Utilize yob2015.txt for this question. This file is similar to yob2016, but contains names, gender, and total children given that name for the year 2015.
##A. Like 1a, please import the .txt file into R. Look at the file before you do. You might have to change some options to import it properly. Again, please give the dataframe human-readable column names. Assign the dataframe to y2015.

```r
 y2015 <- read.table('yob2015.txt', header = FALSE, sep = ',', col.names = c('First.Name', 'Sex', 'Frequency'))
```
##B. Display the last ten rows in the dataframe. Describe something you find interesting about these 10 rows.

```r
tail(y2015, 10)
```

```
##       First.Name Sex Frequency
## 33054       Ziyu   M         5
## 33055       Zoel   M         5
## 33056      Zohar   M         5
## 33057     Zolton   M         5
## 33058       Zyah   M         5
## 33059     Zykell   M         5
## 33060     Zyking   M         5
## 33061      Zykir   M         5
## 33062      Zyrus   M         5
## 33063       Zyus   M         5
```
The data are organized first by descending frequency and second alphabetically by first name.

##C. Merge y2016 and y2015 by your Name column; assign it to final. The client only cares about names that have data for both 2016 and 2015; there should be no NA values in either of your amount of children rows after merging.

```r
y2016$First.Name <- as.character(y2016$First.Name)
y2016$First.Name[which(y2016$Sex=='M')] <- paste(y2016$First.Name[which(y2016$Sex=='M')], '(M)')
y2016$First.Name[which(y2016$Sex=='F')] <- paste(y2016$First.Name[which(y2016$Sex=='F')], '(F)')
y2015$First.Name <- as.character(y2015$First.Name)
y2015$First.Name[which(y2015$Sex=='M')] <- paste(y2015$First.Name[which(y2015$Sex=='M')], '(M)')
y2015$First.Name[which(y2015$Sex=='F')] <- paste(y2015$First.Name[which(y2015$Sex=='F')], '(F)')
final <- merge(y2015, y2016, by = 'First.Name', all = FALSE)
final <- final[,c(1,2,3,5)]
colnames(final) <- c('First.Name', 'Sex', 'Freq.2015', 'Freq.2016')
head(final,10)
```

```
##       First.Name Sex Freq.2015 Freq.2016
## 1      Aaban (M)   M        15         9
## 2      Aabha (F)   F         7         7
## 3  Aabriella (F)   F         5        11
## 4      Aadam (M)   M        22        18
## 5    Aadarsh (M)   M        15        11
## 6      Aaden (M)   M       297       194
## 7     Aadhav (M)   M        31        28
## 8   Aadhavan (M)   M         5         6
## 9      Aadhi (M)   M        11         5
## 10   Aadhira (F)   F         8        14
```
#3. Data Summary (30 points): Utilize your data frame object final for this part.
##A. Create a new column called “Total” in final that adds the amount of children in 2015 and 2016 together. In those two years combined, how many people were given popular names?

```r
final$Total <- final$Freq.2015 + final$Freq.2016
sum(final$Total)
```

```
## [1] 7239231
```
##B. Sort the data by Total. What are the top 10 most popular names?

```r
final <- final[order(final$Total, decreasing = TRUE),]
head(final, 10)
```

```
##         First.Name Sex Freq.2015 Freq.2016 Total
## 8290      Emma (F)   F     20415     19414 39829
## 19886   Olivia (F)   F     19638     19246 38884
## 19594     Noah (M)   M     19594     19015 38609
## 16114     Liam (M)   M     18330     18138 36468
## 23273   Sophia (F)   F     17381     16070 33451
## 3252       Ava (F)   F     16340     16237 32577
## 17715    Mason (M)   M     16591     15192 31783
## 25241  William (M)   M     15863     15668 31531
## 10993    Jacob (M)   M     15914     14416 30330
## 10682 Isabella (F)   F     15574     14722 30296
```
##C. The client is expecting a girl! Omit boys and give the top 10 most popular girl’s names. Assign this to object girl.

```r
girl <- final[which(final$Sex == 'F'),]
girl <- head(girl, 10)
```
##D. Write these top 10 girl Names and their Totals to a CSV file called itsagirl.csv. Do not include row labels. Leave out columns other than Name and Total.

```r
write.csv(girl[,c(1,5)], file = 'itsagirl.csv', row.names = FALSE)
```
#4. Upload to GitHub (10 points): Push at minimum your RMarkdown for this homework assignment and a Readme file with Codebook to one of your GitHub repositories (you might place this in a Homework repo like last week). It does not have to be too detailed. The Codebook should contain a short definition of each object you create. You are welcome and encouraged to add other files—just make sure you have a description and directions that are helpful for the grader.
