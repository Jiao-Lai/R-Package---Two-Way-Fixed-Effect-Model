## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(gssquery)

## -----------------------------------------------------------------------------
data(GSS)
GetAttributes(data = GSS)

## -----------------------------------------------------------------------------
query<-QueryAttributes(data = GSS,'happy','health','income')
head(query)

## -----------------------------------------------------------------------------
LmData <- GetCleanLmData(data = GSS, y = 'happy.score', x = 'election', FE = 'year', common.na.strings = c("DK", "IAP", "UNCODEABLE & IAP", ".a", ".b","DK NA"), 'age', 'income', 'health', 'educ')
head(LmData)
LmData.reelec <- GetCleanLmData(data = GSS[GSS$re.election != 1,], y = 'happy.score', x = 're.election', FE = 'year', common.na.strings = c("DK", "IAP", "UNCODEABLE & IAP", ".a", ".b","DK NA"), 'age', 'income', 'health', 'educ')
head(LmData.reelec)
LmData.elec <- GetCleanLmData(data = GSS[GSS$re.election != 2,], y = 'happy.score', x = 're.election', FE = 'year', common.na.strings = c("DK", "IAP", "UNCODEABLE & IAP", ".a", ".b","DK NA"), 'age', 'income', 'health', 'educ')
head(LmData.elec)

## -----------------------------------------------------------------------------
library(dplyr)
LmData <- LmData %>% mutate(age = as.numeric(age)) %>% filter(age<=60)
summary(Analysis.lm(data = LmData, y = 'happy.score', FE = 'year'))


## -----------------------------------------------------------------------------
LmData.reelec <- LmData.reelec %>% mutate(age = as.numeric(age)) %>% filter(age<=60)
summary(Analysis.lm(data = LmData.reelec, y = 'happy.score', FE = 'year'))


## -----------------------------------------------------------------------------
LmData.elec <- LmData.elec %>% mutate(age = as.numeric(age)) %>% filter(age<=60)
summary(Analysis.lm(data = LmData.elec, y = 'happy.score', FE = 'year'))

## -----------------------------------------------------------------------------
LagEffect(data = LmData, y = 'happy.score', x = 'election', time = 'year', FE = 'year')



## -----------------------------------------------------------------------------
LagEffect(data = LmData.elec, y = 'happy.score', x = 're.election', time = 'year', FE = 'year')


## -----------------------------------------------------------------------------
LagEffect(data = LmData.reelec, y = 'happy.score', x = 're.election', time = 'year', FE = 'year')


## -----------------------------------------------------------------------------
LeadEffect(data = LmData, y = 'happy.score', x = 'election', time = 'year', FE = 'year')


## -----------------------------------------------------------------------------
LeadEffect(data = LmData.elec, y = 'happy.score', x = 're.election', time = 'year', FE = 'year')

## -----------------------------------------------------------------------------
LeadEffect(data = LmData.reelec, y = 'happy.score', x = 're.election', time = 'year', FE = 'year')


## -----------------------------------------------------------------------------
PlaceboTSReshuffle(data = LmData, y = 'happy.score', x = 'election', FE = 'year')
PlaceboTSReshuffle(data = LmData.elec, y = 'happy.score', x = 're.election', FE = 'year')
PlaceboTSReshuffle(data = LmData.reelec, y = 'happy.score', x = 're.election', FE = 'year')



## -----------------------------------------------------------------------------
PlaceboLOU(data = LmData, y = 'happy.score', x = 'election', FE = 'year', out = 'year')
PlaceboLOU(data = LmData.elec, y = 'happy.score', x = 're.election', FE = 'year', out = 'year')
PlaceboLOU(data = LmData.reelec, y = 'happy.score', x = 're.election', FE = 'year', out = 'year')


## -----------------------------------------------------------------------------
PlotAttribute(data = GSS, attr = "happy", group.by = "year")
PlotAttribute(data = GSS, attr = "age", group.by = "year")

