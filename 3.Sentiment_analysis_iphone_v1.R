########################################
# Name: Francesca Prata                #
# Project: Sentiment Analysis          #
# Script: Applying model to Big Matrix #
# Date: 30 March 2019                  #
# Version: 1                           #
########################################

#Retrieving previous dataframe 
source(file = "2.RandomForest_IPHONE_v2.R")

#Importing big matrix
bigiphonematrix <- read.csv("BigMatrix.csv")

#Subsetting matrix so that it only contains ios and iphone
bigiphonematrix <- bigiphonematrix %>% 
  select(starts_with("ios"), starts_with("iphone"))

#Making sure that iphone is mentioned at least once in the website
bigiphonematrix <- bigiphonematrix %>% filter(iphone > 0)

#Applying the model
predictions <- predict(RFfitsentiment, newdata = bigiphonematrix)
summary(predictions)
prop.table(table(predictions))