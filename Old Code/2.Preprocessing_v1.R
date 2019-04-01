################################################
# Name: Francesca Prata                        #
# Project: Sentiment Analysis                  #
# Script: Pre-processing and feature selection #
# Date: 26 March 2019                          #
# Version: 1                                   #
################################################

#Examing correlation
iphoneNOsent <- iphonematrix %>% 
  select(- ends_with("sentiment"))
iphoneCOR <- cor(iphoneNOsent)

options(max.print=1000000)
corrplot(iphoneCOR, tl.cex = 0.5)

iphoneSELECT <- iphonematrix %>% 
  select(starts_with("iphone"))

iphoneSELECT <- iphonematrix %>% 
  select(starts_with("iphone"), -iphonesentiment, -iphone)

iphoneSELECTcor <- cor(iphoneSELECT)
corrplot(iphoneSELECTcor)

#Examine Feature variance
nzvMetrics <- nearZeroVar(iphoneSELECT, saveMetrics = TRUE)
nzvMetrics

nzv <- nearZeroVar(iphoneSELECT, saveMetrics = FALSE) 
nzv

#Create new dataframe with no near zero variance
iphoneNZV <- iphoneSELECT[, -nzv]
str(iphoneNZV)

#Recursive feature elimination

# Stop Cluster. After performing your tasks, stop your cluster. 
stopCluster(cl)
