################################################
# Name: Francesca Prata                        #
# Project: Sentiment Analysis                  #
# Script: Pre-processing and feature selection #
# Date: 26 March 2019                          #
# Version: 1                                   #
################################################

#let us recode the iphonesentiment variables from 0-6 levels
#to only 2 levels (1 and 4) 
iphonematrix$Recode <- recode(iphonematrix$iphonesentiment, 
                          '0' = 1, '1' = 1, '2' = 2,
                          '3' = 3, '4' = 4, '5' = 4) 

iphonematrix <- iphonematrix %>% 
  select(-iphonesentiment)

###############################
#Consider only iphone and ios #
###############################

#Subset matrix so that it only contains iphone and ios 
iphoneSELECT <- iphonematrix %>% 
  select(starts_with("ios"), starts_with("iphone"))

#Distribution of iphonesentiment 
plot_ly(iphoneSELECT,
        x = ~iphoneSELECT$iphonesentiment,
        type = 'histogram')

#########################################################
#Consider only iphone and ios and no near zero variance #
#########################################################

#Examine Feature variance
nzvMetrics <- nearZeroVar(iphoneSELECT, saveMetrics = TRUE)
nzvMetrics

nzv <- nearZeroVar(iphoneSELECT, saveMetrics = FALSE) 
nzv

#Create new dataframe with no near zero variance
iphoneNZV <- iphoneSELECT[, -nzv]

############################
#Excluding variable iphone #
############################

iphoneNO <- iphoneNZV %>% 
  select(-iphone)
