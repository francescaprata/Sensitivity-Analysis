################################
# Name: Francesca Prata        #
# Project: Sentiment Analysis  #
# Script: Model C5 with recode #
# Date: 27 March 2019          #
# Version: 2                   #
################################

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
fitcontrolC5 <- trainControl(method = "repeatedcv",
                             number = 10,
                             repeats = 1,
                             preProc = c("center", "scale", "range"))

#Training C5 model
set.seed(123)
C5fitsentiment <- train(Recode~.,
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
postResample(predsentC5, testing$Recode)
confusionMatrix(testing$predsentC5, testing$Recode)
