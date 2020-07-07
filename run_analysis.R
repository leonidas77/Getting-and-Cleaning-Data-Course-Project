#Peer-graded Assignment: Getting and Cleaning Data Course Project
#July 7, 2020

#Load library
library(dplyr)

#If file doesn't exist proceed to download and unzip
fileName <- "UCI_HAR_Dataset.zip"
if (!file.exists(fileName)){
  URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(URL, fileName, method = "curl")
  unzip(fileName)
}
#(Read sets)
#Read Activity Labels and Features, common for both sets
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
features <- read.table("UCI HAR Dataset/features.txt")

#Read Test set
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")

#Read Training set
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")

#(Step 1)Merges the training and the test sets to create one data set.
#(Step 1.1) Bind test and train sets
subject <- rbind(subject_test,subject_train)
x <- rbind(x_test,x_train)
y <- rbind(y_test,y_train)

#(Step 1.2) Adding column names to be able to merge using common names
colnames(x) <- features[,2]
colnames(y) <- "activityid"
colnames(subject) <- "subjectid"
colnames(activity_labels) <- c("activityid","activity")

#(Step 1.3) Merge y subject and x
mergedata <- cbind(y, subject, x)

#(Step 2)Extracts only the measurements on the mean and standard deviation for each measurement.
mergedata <- select(mergedata,"activityid", "subjectid", contains("mean"), contains("std"))

#(Step 3)Uses descriptive activity names to name the activities in the data set
mergedata$activityid <- activity_labels[mergedata$activityid,2]

#(Step 4)Appropriately labels the data set with descriptive variable names.
names(mergedata)[1] = "activity"
names(mergedata)[2] = "subjectid"
names(mergedata)<-gsub("tBody", "TimeBody", names(mergedata), ignore.case = TRUE)
names(mergedata)<-gsub("tGravity", "TimeGravity", names(mergedata), ignore.case = TRUE)
names(mergedata)<-gsub("^f", "Frequency", names(mergedata), ignore.case = TRUE)
names(mergedata)<-gsub("^t", "Time", names(mergedata), ignore.case = TRUE)
names(mergedata)<-gsub("-mean()", "Mean", names(mergedata), ignore.case = TRUE)
names(mergedata)<-gsub("-std()", "Standard", names(mergedata), ignore.case = TRUE)
names(mergedata)<-gsub("-freq()", "Frequency", names(mergedata), ignore.case = TRUE)
names(mergedata)<-gsub("Acc", "Accelerometer", names(mergedata), ignore.case = TRUE)
names(mergedata)<-gsub("Gyro", "Gyroscope", names(mergedata), ignore.case = TRUE)
names(mergedata)<-gsub("BodyBody", "Body", names(mergedata), ignore.case = TRUE)
names(mergedata)<-gsub("Mag", "Magnitude", names(mergedata), ignore.case = TRUE)
names(mergedata)<-gsub("angle", "Angle", names(mergedata), ignore.case = TRUE)
names(mergedata)<-gsub("gravity", "Gravity", names(mergedata), ignore.case = TRUE)

#(Step 5)From the data set in step 4, creates a second, independent tidy data 
#        set with the average of each variable for each activity and each subject.
finalfile <- mergedata %>% 
  group_by(subjectid, activity) %>%
  summarise_all(funs(mean))

#(Step 5.1 )Save the final data set
write.table(finalfile, "final_data.txt", row.names = FALSE, 
            quote = FALSE)

