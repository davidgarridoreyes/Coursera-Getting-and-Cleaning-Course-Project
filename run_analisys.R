run_analisys <- function(){
	## Load Packages:
	library(dplyr)
	library(plyr)
	## Load the datasets:
	activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
	features <- read.table("UCI HAR Dataset/features.txt")

	subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
	x_test <- read.table("UCI HAR Dataset/test/X_test.txt")
	y_test <- read.table("UCI HAR Dataset/test/y_test.txt")

	subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")	
	x_train <- read.table("UCI HAR Dataset/train/X_train.txt")	
	y_train <- read.table("UCI HAR Dataset/train/y_train.txt")

	## Rename measurements in dataframes:
	colnames(x_test) <- features$V2
	colnames(y_test) <- "activity"
	colnames(subject_test) <- "subject"

	colnames(x_train) <- features$V2
	colnames(y_train) <- "activity"
	colnames(subject_train) <- "subject"

	## Keep only mean or standard deviation values of features measured:
	chosenFeaturesTest <- grep("[Mm]ean|std", names(x_test))
	x_test <- x_test[,chosenFeaturesTest]

	chosenFeaturesTrain <- grep("[Mm]ean|std", names(x_train))
	x_train <- x_train[,chosenFeaturesTrain]

	##Identify activity labels in y_test and y_train:
	levels <- activity_labels$V1
	labels <- activity_labels$V2
	
	y_test$activity <- factor(y_test$activity, levels, labels)
	y_train$activity <- factor(y_train$activity, levels, labels)

	## Defining test and train dataframes:
	testData <- cbind(y_test, x_test)
	testData <- cbind(subject_test, testData)

	trainData <- cbind(y_train, x_train)
	trainData <- cbind(subject_train, trainData)

	## Merge trainData and testData for form the complete dataframe:
	completeData <- rbind(testData, trainData)

	## Label the completeData with descriptive variable names:
	names(completeData) <- gsub("^t", "time", names(completeData))
	names(completeData) <- gsub("^f", "frequency", names(completeData))
	names(completeData) <- gsub("Acc", "Accelerometer", names(completeData))
	names(completeData) <- gsub("Gyro", "Gyroscope", names(completeData))
	names(completeData) <- gsub("Mag", "Magnitude", names(completeData))
	names(completeData) <- gsub("BodyBody", "Body", names(completeData))

	## From completeData, we create a data set with the average of each
	## variable for each activity and each subject and save it into a txt file.
	tidyData <- aggregate(. ~subject + activity, completeData , mean)
	write.table(tidyData, "./tidyData.txt", row.names = FALSE, quote = FALSE)

}