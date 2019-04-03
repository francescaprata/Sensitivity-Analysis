#################################
# Name: Francesca Prata         #
# Project: Sentiment Analysis   #
# Script: KNN model with recode #
# Date: 27 March 2019           #
# Version: 1                    #
#################################

#Retrieving previous dataframe 
source(file = "")

#Set iphonesentiment as factor
iphonematrix$Recode <- as.factor(iphonematrix$Recode)

#Data partition
set.seed(123)
inTrain <- createDataPartition(y = iphonematrix$Recode,
                               p=0.7,
                               list = FALSE)

#Separating the data into training and testing
training <- iphonematrix[inTrain,]
testing <- iphonematrix[-inTrain,]

#Setting cross validation parameters
fitcontrolKNN <- trainControl(method = "repeatedcv",
                              number = 10,
                              repeats = 1,
                              preProc = c("center", "scale", "range"))
#Training KNN model
set.seed(123)
Knnfitsentiment <- train(Recode~.,
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
postResample(predsentKNN, testing$Recode)
confusionMatrix(testing$predsentKNN, testing$Recode)
