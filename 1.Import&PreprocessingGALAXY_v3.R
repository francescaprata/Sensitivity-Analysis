###############################
# Name: Francesca Prata       #
# Project: Sentiment Analysis #
# Script: Galaxy set-up       #
# Date: 30 March 2019         #
# Version: 3                  #
###############################

#Loading required packages
if(!require(pacman))install.packages("pacman")

pacman::p_load('doParallel', 'plotly', 'caret', 'corrplot', 'dplyr',
               "e1071", "kknn", 'ROSE')

#Importing dataset 
galaxymatrix <- read.csv("galaxy_smallmatrix_labeled_8d.csv")

#Subsetting matrix so that it only contains samsung and galaxy
galaxymatrix <- galaxymatrix %>% 
  select(starts_with("samsung"), starts_with("galaxy"))

#Making sure that samsung galaxy is mentioned at least once in the website
galaxymatrix <- galaxymatrix %>% filter(samsunggalaxy > 0)

#Recoding galaxysentiment from 6 to only 2 levels  
galaxymatrix$galaxysentiment <- recode(galaxymatrix$galaxysentiment, 
                                       '0' = 1, '1' = 1, '2' = 1,
                                       '3' = 5, '4' = 5, '5' = 5)

#Balancing the dataset 
galaxymatrix <- ovun.sample(galaxysentiment~., data=galaxymatrix,
                            N=nrow(galaxymatrix), p=0.5, 
                            seed=1, method="both")$data

#Checking that galaxysentiment is a factor
galaxymatrix$galaxysentiment <- as.factor(galaxymatrix$galaxysentiment)
