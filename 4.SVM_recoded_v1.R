#################################
# Name: Francesca Prata         #
# Project: Sentiment Analysis   #
# Script: Model SVM with recode #
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
fitcontrolSVM <- trainControl(method = "repeatedcv",
                              number = 10,
                              repeats = 1,
                              preProc = c("center", "scale", "range"))
#Training SVM model
set.seed(123)
Svmfitsentiment <- train(Recode~.,
                         training,
                         method = "svmLinear",
                         metric = "Accuracy",
                         tuneLength = 1,
                         trControl = fitcontrolSVM)

#Predicting iphonesentiment from the training data
predsentSVM <- predict(Svmfitsentiment, newdata = testing)

#Creating new column with predictions
testing$predsentSVM <- predsentSVM

#Checking the metrics
postResample(predsentSVM, testing$Recode)
confusionMatrix(testing$predsentSVM, testing$Recode)
