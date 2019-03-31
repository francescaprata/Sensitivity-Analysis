##########################################
# Name: Francesca Prata                  #
# Project: Sentiment Analysis            #
# Script: Model Random Forest for GALAXY #
# Date: 27 March 2019                    #
# Version: 1                             #
##########################################

#Retrieving previous dataframe 
source(file = "1.Import&PreprocessingGALAXY_v3.R")

#Data partition
set.seed(123)
inTrain <- createDataPartition(y = galaxymatrix$galaxysentiment,
                               p=0.7,
                               list = FALSE)

#Separating the data into training and testing
training <- galaxymatrix[inTrain,]
testing <- galaxymatrix[-inTrain,]

#Setting cross validation parameters
fitcontrolRF <- trainControl(method = "repeatedcv",
                             number = 10,
                             repeats = 1)
                             
#Training Random Forest model
set.seed(123)
RFfitsentiment <- train(galaxysentiment ~ .,
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
postResample(predsentRF, testing$galaxysentiment)
confusionMatrix(testing$predsentRF, testing$galaxysentiment)