setwd('C:/Users/Aditya/Desktop/rainfall-prediction')

suppressMessages({
  library('data.table')
  library('dplyr')
  library('mice')
  
})

rainfall <- read.csv("input/rainfall in india 1901-2015.csv", stringsAsFactors = F)

md.pattern(rainfall)

rainfall$ANNUAL <- NULL
rainfall$Jan.Feb <- NULL
rainfall$Mar.May <- NULL
rainfall$Jun.Sep <- NULL
rainfall$Oct.Dec <- NULL

tempData <- mice(rainfall,m=5,maxit=50,meth='pmm',seed=500)

rainfall_new <- complete(tempData,1)

sapply(rainfall_new, function(x) table((is.na(x))))

rainfall_new$ANNUAL <- rainfall_new$JAN + rainfall_new$FEB + rainfall_new$MAR + rainfall_new$APR + 
  rainfall_new$MAY + rainfall_new$JUN + rainfall_new$JUL + rainfall_new$AUG + 
  rainfall_new$SEP + rainfall_new$OCT + rainfall_new$NOV + rainfall_new$DEC 

rainfall_new$Jan.Feb <- rainfall_new$JAN + rainfall_new$FEB
rainfall_new$Mar.May <- rainfall_new$MAR + rainfall_new$APR + rainfall_new$MAY
rainfall_new$Jun.Sep <- rainfall_new$JUN + rainfall_new$JUL + rainfall_new$AUG + rainfall_new$SEP
rainfall_new$Oct.Dec <- rainfall_new$OCT + rainfall_new$NOV + rainfall_new$DEC

write.csv(rainfall_new, file = "input/rainfall in india 1901-2015_imputed2.csv", row.names = F)
