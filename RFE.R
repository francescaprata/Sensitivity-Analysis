# Let's sample the data before using RFE
set.seed(123)
iphoneSample <- iphoneSELECT[sample(1:nrow(iphoneSELECT), 1000, replace=FALSE),]

# Set up rfeControl with randomforest, repeated cross validation and no updates
ctrl <- rfeControl(functions = rfFuncs, 
                   method = "repeatedcv",
                   repeats = 5,
                   verbose = FALSE)

# Use rfe and omit the response variable (attribute 15 iphonesentiment) 
rfeResults <- rfe(iphoneSample[,1:14],
                  iphoneSample$iphonesentiment,
                  sizes = (1:14),
                  rfeControl = ctrl)





rfeResults <- rfe(data=iphoneSELECT  , 
                 (iphoneSELECT$iphonesentiment) ~ ., 
                   rfeControl=ctrl)

# Get results
rfeResults

# Plot results
plot(rfeResults, type=c("g", "o"))
varImp(rfeResults)
#see predictors
predictors(rfeResults)

cor(iphoneSELECT)

