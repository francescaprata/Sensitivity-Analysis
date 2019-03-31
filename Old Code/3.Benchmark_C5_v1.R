###############################
# Name: Francesca Prata       #
# Project: Sentiment Analysis #
# Script: Benchmark C5        #
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
fitcontrolC5 <- trainControl(method = "repeatedcv",
                              number = 10,
                              repeats = 1)
#Training KNN model
set.seed(123)
C5fitsentiment <- train(iphonesentiment~.,
                         training,
                         method = "C5.0",
                         metric = "Accuracy",
                         tuneLength = 1,
                         trControl = fitcontrolC5)

#Predicting iphonesentiment from the training data
predsentC5 <- predict(C5fitsentiment, newdata = testing)

#Creating new column with predictions
testing$predsentC5 <- predsentC5

#Checking the metrics
confusionMatrix(testing$predsentC5, testing$iphonesentiment)



