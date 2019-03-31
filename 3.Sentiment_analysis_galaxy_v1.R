########################################
# Name: Francesca Prata                #
# Project: Sentiment Analysis          #
# Script: Applying model to Big Matrix #
# Date: 30 March 2019                  #
# Version: 1                           #
########################################

#Retrieving previous dataframe 
source(file = "2.RandomForest_GALAXY_v2.R")

#Importing big matrix
biggalaxymatrix <- read.csv("BigMatrix.csv")

#Subsetting matrix so that it only contains samsung and galaxy
biggalaxymatrix <- biggalaxymatrix %>% 
  select(starts_with("samsung"), starts_with("galaxy"))

#Making sure that samsung galaxy is mentioned at least once in the website
biggalaxymatrix <- biggalaxymatrix %>% filter(samsunggalaxy > 0)

#Applying the model
predictions <- predict(RFfitsentiment, newdata = biggalaxymatrix)
summary(predictions)
prop.table(table(predictions))