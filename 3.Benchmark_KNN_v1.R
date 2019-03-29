###############################
# Name: Francesca Prata       #
# Project: Sentiment Analysis #
# Script: Benchmark KNN       #
# Date: 26 March 2019         #
# Version: 1                  #
###############################

#Retrieving previous dataframe 
source(file = "")

#Set iphonesentiment as factor
iphonematrix$iphonesentiment <- as.factor(iphonematrix$iphonesentiment)

#Data partition
set.seed(123)
inTrain <- createDataPartition(y = iphonematrix$iphonesentiment,
                               p=0.7,
                               list = FALSE)

#Separating the data into training and testing
training <- iphonematrix[inTrain,]
testing <- iphonematrix[-inTrain,]

#Setting cross validation parameters
fitcontrolKNN <- trainControl(method = "repeatedcv",
                              number = 10,
                              repeats = 1)
#Training KNN model
set.seed(123)
Knnfitsentiment <- train(iphonesentiment~.,
                         training,
                         method = "kknn",
                         metric = "Accuracy",
                         tuneLength = 1,
                         trControl = fitcontrolKNN)

#Predicting iphonesentiment from the training data
predsentKNN <- predict(Knnfitsentiment, newdata = testing)

#Creating new column with predictions
testing$predsentKNN <- predsentKNN

#Checking the metrics
confusionMatrix(testing$predsentKNN, testing$iphonesentiment)



  
