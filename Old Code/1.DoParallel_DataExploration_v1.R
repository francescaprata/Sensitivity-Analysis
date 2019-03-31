###############################
# Name: Francesca Prata       #
# Project: Sentiment Analysis #
# Script: Setting Do Parallel and initial data exploration #
# Date: 26 March 2019         #
# Version: 1                  #
###############################

# Required
if(!require(pacman))install.packages("pacman")

pacman::p_load('doParallel', 'plotly', 'caret', 'corrplot', 'dplyr',
               "e1071", "kknn")

#######################
# Setting Do Parallel #
#######################

# Find how many cores are on your machine
detectCores() #In my case there are 8

# Create Cluster with desired number of cores. Don't use them all! Your computer is running other processes. 
cl <- makeCluster(6)

# Register Cluster
registerDoParallel(cl)

# Confirm how many cores are now "assigned" to R and RStudio
getDoParWorkers() # Result 6


####################
# Data Exploration #
####################

#Importing the dataset
iphonematrix <- read.csv("iphone_smallmatrix_labeled_8d.csv")

#Checking for missing data
iphonematrix[!complete.cases(iphonematrix),]
#There are no missing values 

#Distribution dependent variable
plot_ly(iphonematrix, 
        x= ~iphonematrix$iphonesentiment, 
        type='histogram')
#It is skewed to the right 
