###############################
# Name: Francesca Prata       #
# Project: Sentiment Analysis #
# Script: Iphone set-up       #
# Date: 30 March 2019         #
# Version: 3                  #
###############################

#Loading required packages
if(!require(pacman))install.packages("pacman")

pacman::p_load('doParallel', 'plotly', 'caret', 'corrplot', 'dplyr',
               "e1071", "kknn", 'ROSE')

#Importing dataset 
iphonematrix <- read.csv("iphone_smallmatrix_labeled_8d.csv")

#Subsetting matrix so that it only contains iphone and ios 
iphonematrix <- iphonematrix %>% 
  select(starts_with("ios"), starts_with("iphone"))

#Making sure that iphone is mentioned at least once in the website
iphonematrix <- iphonematrix %>% filter(iphone > 0)

#Recoding iphonesentiment from 6 to only 2 levels  
iphonematrix$iphonesentiment <- recode(iphonematrix$iphonesentiment, 
                              '0' = 1, '1' = 1, '2' = 1,
                              '3' = 5, '4' = 5, '5' = 5)

#Balancing the dataset 
iphonematrix <- ovun.sample(iphonesentiment~., data=iphonematrix,
                              N=nrow(iphonematrix), p=0.5, 
                              seed=1, method="both")$data

#Checking that iphonesentiment is a factor
iphonematrix$iphonesentiment <- as.factor(iphonematrix$iphonesentiment)