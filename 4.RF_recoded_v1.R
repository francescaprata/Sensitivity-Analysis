###########################################
# Name: Francesca Prata                   #
# Project: Sentiment Analysis             #
# Script: Model Random Forest with recode #
# Date: 27 March 2019                     #
# Version: 1                              #
###########################################

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
fitcontrolRF <- trainControl(method = "repeatedcv",
                             number = 10,
                             repeats = 3,
                             preProc = c("center", "scale", "range"))

#Training Random Forest model
set.seed(123)
RFfitsentiment <- train(Recode~.,
                        training,
                        method = "parRF",
                        metric = "Accuracy",
                        tuneLength = 1,
                        trControl = fitcontrolRF)

#Predicting iphonesentiment from the training data
predsentRF <- predict(RFfitsentiment, newdata = testing)

#Creating new column with predictions
testing$predsentRF <- predsentRF

#Checking the metrics
postResample(predsentRF, testing$Recode)
confusionMatrix(testing$predsentRF, testing$Recode)
