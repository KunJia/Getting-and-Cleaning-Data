## Create one R script called run_analysis.R that does the following:
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive activity names.
## 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.library(reshape2)

# Check if need to install the package

if (!require('data.table')) {
          install.packages('data.table')
}

if (!require('reshape2')) {
          install.packages('reshape2')
}

library(data.table)
library(reshape2)

filename <- "getdata-projectfiles-UCI HAR Dataset.zip"

# Download the dataset:
if (!file.exists(filename)){
          fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
          download.file(fileURL, filename, method="curl")
}  
# unzip the dataset file if needed:
if (!file.exists("UCI HAR Dataset")) { 
          unzip(filename) 
}

# Load activity labels:
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
activity_labels[,2] <- as.character(activity_labels[,2])

# Load the features:
features <- read.table("UCI HAR Dataset/features.txt")
features[,2] <- as.character(features[,2])

# Extract only the data on mean and standard deviation
features_select <- grep(".*mean.*|.*std.*", features[,2])
features_select.names <- features[features_select,2]
features_selectd.names = gsub('-mean', 'Mean', features_select.names)
features_select.names = gsub('-std', 'Std', features_select.names)
features_select.names <- gsub('[-()]', '', features_select.names)


# Load the datasets
train <- read.table("UCI HAR Dataset/train/X_train.txt")[features_select]
train_activities <- read.table("UCI HAR Dataset/train/Y_train.txt")
train_subjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
train <- cbind(train_subjects, train_activities, train)

test <- read.table("UCI HAR Dataset/test/X_test.txt")[features_select]
test_activities <- read.table("UCI HAR Dataset/test/Y_test.txt")
test_subjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
test <- cbind(test_subjects, test_activities, test)

# merge datasets and add labels
data_all <- rbind(train, test)
colnames(data_all) <- c("subject", "activity", features_select.names)

# turn activities & subjects into factors
data_all$activity <- factor(data_all$activity, levels = activity_labels[,1], labels = activity_labels[,2])
data_all$subject <- as.factor(data_all$subject)

# apply mean function to the dataset
data_all.melted <- melt(data_all, id = c("subject", "activity"))
data_all.mean <- dcast(data_all.melted, subject + activity ~ variable, mean)

# write the output file
write.table(data_all.mean, "tidy_data.txt", row.names = FALSE, quote = FALSE)