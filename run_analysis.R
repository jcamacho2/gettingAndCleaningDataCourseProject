library(dplyr)

#load data. Assumes your current directory is in the UCI HAR Dataset folder
test <- read.table("./test/X_test.txt", sep = "")
train <- read.table("./train/X_train.txt", sep = "")
featureNames <- read.table("features.txt", sep = "")
activityLabels <- read.table("activity_labels.txt", sep = "")
activityTest <- read.table("./test/y_test.txt", sep = "")
activityTrain <- read.table("./train/y_train.txt", sep = "")
subjectTrain <- read.table("./train/subject_train.txt", sep = "")
subjectTest <- read.table("./test/subject_test.txt", sep = "")

#assign column names to features in the test and train sets
featureNames <- select(featureNames, V2)
featureNames <- featureNames$V2
featureNames <- as.character(featureNames)
featureNames <- sub("-","", featureNames) #get rid of "-" in feature vector
featureNames <- sub("[(]","",featureNames) #get rid of "(" in feature vector
featureNames <- sub("[)]","", featureNames) #get rid of ")" in feature vector
featureNames <- sub("[,]","", featureNames) #get rid of "," in feature vector
featureNames <- tolower(featureNames)
names(train) <- featureNames
names(test) <- featureNames

#assign column names. Combine activityTest, subjectTest, and test dataframes by column.
names(activityTest) <- "activity"
names(subjectTest) <- "subject"
test <- cbind(activityTest, subjectTest, test)

#assign column names. Combine activityTrain, subjectTrain, and train dataframes by column.
names(activityTrain) <- "activity"
names(subjectTrain) <- "subject"
train <- cbind(activityTrain, subjectTrain, train)

############################## 1. Merge training and test sets to create one data set. ##############################
mydata <- rbind(test, train)

############################## 2. Extracts only the measurements on the mean and std for each measurement ##############################
mydata <- mydata[,grep("activity|subject|mean|std", names(mydata))]

############################## 3. Uses descriptive activity names to name the activities in data set ##############################
activityLabels <- activityLabels$V2
activityLabels <- as.character(activityLabels)
activityLabels <- sub("_", "", activityLabels)
activityLabels <- tolower(activityLabels)
idx <- setNames(activityLabels, 1:6)
mydata$activity <- sapply(mydata$activity, function(x) idx[[x]]) #replaces the integers with appropriate activity label

##############################  4. Appropriately label the data set with descriptive varialble names ##############################  
#already taken care of in earlier steps


##############################  5. Create a 2nd independently tidy data set with the average for each variable, activity, and subject ##############################  

#create empty data frame - the independent tidy data set
df <- data.frame(matrix(nrow = 0, ncol = 4))
names(df) <- c("subject", "activity", "measurement", "mean")
newFeatures <- names(mydata)
newFeatures <- newFeatures[grep("mean|std", newFeatures)]

#fill the empty data set with the relevant information
idx = 1
for (subj in 1:30){
  for(act in activityLabels){
    for(feature in newFeatures){
      tempdf <- filter(mydata, activity == act, subject == subj)
      myMean <- mean(tempdf[,feature])
      df[idx,] <- c(subj, act, feature, myMean)
      idx = idx + 1
    }
  }
}

############## This is the end product! ############################
# head(df)
#subject activity    measurement                mean
#1       1  walking tbodyaccmean-x   0.277330758736842
#2       1  walking tbodyaccmean-y -0.0173838185273684
#3       1  walking tbodyaccmean-z  -0.111148103547368
#4       1  walking  tbodyaccstd-x  -0.283740258842105
#5       1  walking  tbodyaccstd-y   0.114461336747368
#6       1  walking  tbodyaccstd-z  -0.260027902210526

#save the ouput
write.table(df, file = "tidyData.txt", row.names = FALSE)



