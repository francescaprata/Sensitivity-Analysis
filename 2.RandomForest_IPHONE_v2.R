##########################################
# Name: Francesca Prata                  #
# Project: Sentiment Analysis            #
# Script: Model Random Forest for IPHONE #
# Date: 30 March 2019                    #
# Version: 2                             #
##########################################

#Retrieving previous dataframe 
source(file = "1.Import&PreprocessingIPHONE_v3.R")

#Data partition
set.seed(123)
inTrain <- createDataPartition(y = iphonematrix$iphonesentiment,
                               p=0.7,
                               list = FALSE)

#Separating the data into training and testing
training <- iphonematrix[inTrain,]
testing <- iphonematrix[-inTrain,]

#Setting cross validation parameters
fitcontrolRF <- trainControl(method = "repeatedcv",
                             number = 10,
                             repeats = 1)

#Training Random Forest model
set.seed(123)
RFfitsentiment <- train(iphonesentiment ~ .,
                        training,
                        method = "rf",
                        metric = "Kappa",
                        tuneLength = 1,
                        trControl = fitcontrolRF)

#Predicting iphonesentiment from the training data
predsentRF <- predict(RFfitsentiment, newdata = testing)

#Creating new column with predictions
testing$predsentRF <- predsentRF

#Checking the metrics
postResample(predsentRF, testing$iphonesentiment)
confusionMatrix(testing$predsentRF, testing$iphonesentiment)