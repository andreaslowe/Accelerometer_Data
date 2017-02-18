#function to merge test and training sets, extract mean and SD, average each variable and subject, and label
run_analysis <- function(testdata = "UCI HAR Dataset/test/X_test.txt", testlabels = "UCI HAR Dataset/test/y_test.txt", 
                         subject_test = "UCI HAR Dataset/test/subject_test.txt",traindata = "UCI HAR Dataset/train/X_train.txt", 
                         trainlabels = "UCI HAR Dataset/train/y_train.txt", subject_train = "UCI HAR Dataset/train/subject_train.txt", 
                         activitylabel = "UCI HAR Dataset/activity_labels.txt", features = "UCI HAR Dataset/features.txt") {

#read in test data + labels
test <- read.table(testdata)
test_label <- read.table(testlabels)
testsubject <- read.table(subject_test)

#read in train data + labels
train <- read.table(traindata)
train_label <- read.table(trainlabels)
trainsubject <- read.table(subject_train)

#read activity and features labels
activity <- read.table(activitylabel)
features <- read.table(features)

#replace the numbers in the data labels (y_test and train) with the descriptions of the activity
test_label <- apply(test_label, 2, function(x) gsub(activity$V1[1], activity$V2[1], x))
for (i in 1:nrow(activity)){
  test_label <- apply(test_label, 2, function(x) gsub(activity$V1[i], activity$V2[i], x))
} 
#same as above, but for train
train_label <- apply(train_label, 2, function(x) gsub(activity$V1[1], activity$V2[1], x))
for (i in 1:nrow(activity)){
  train_label <- apply(train_label, 2, function(x) gsub(activity$V1[i], activity$V2[i], x))
} 

#create test and train data sets that have appropriate labels for the subject, activity, and measurement
#essentially attaching desriptive activity names (+ subjects) to data sets
complete_test <- data.frame(test)
colnames(complete_test) <- features$V2
complete_test$Activity <- as.character(test_label)
complete_test$Subject <- as.numeric(unlist(testsubject))

#same as above but for train set
complete_train <- data.frame(train)
colnames(complete_train) <- features$V2
complete_train$Activity <- as.character(train_label)
complete_train$Subject <- as.numeric(unlist(trainsubject))

library(dplyr) #load dplyr library

#identify columns which have either the mean or standard deviation, by searching these strings on the features data
ind <- grep("mean|std", features$V2)
ind <- c(ind,562:563)

#extract only the measurements on the mean and standard deviation  for each measurement using above index
complete_test <- complete_test[ind]
complete_train <- complete_train[ind]

#merge test and train data sets
merged_data <<- rbind(complete_test, complete_train)

##From the data set in step 4, creates a second, independent tidy data set with the average 
##of each variable for each activity and each subject.        
tidy_data <<- group_by(merged, Activity, Subject) %>% summarize_all(funs(mean))

write.table(tidy_data, "Tidy_Data_Accelerometer", row.names = FALSE)        
}