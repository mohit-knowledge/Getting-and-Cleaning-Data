# R script for Course Project of Getting and Cleaning Data
# Data for this project was taken from: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

# Merge the training and the test sets

X_train <- read.table("train/X_train.txt") 
X_test <- read.table("test/X_test.txt") 
X_merge <- rbind(X_train, X_test) 

subject_train <- read.table("train/subject_train.txt") 
subject_test <- read.table("test/subject_test.txt") 
subject_merge <- rbind(subject_train, subject_test) 

y_train <- read.table("train/y_train.txt") 
y_test <- read.table("test/y_test.txt") 
y_merge <- rbind(y_train, y_test) 

# Extract only the measurements on the mean and standard deviation for each measurement

features <- read.table("features.txt") 
mean_std_features <- grep("-mean\\(\\)|-std\\(\\)", features[, 2]) 
X_mean_std <- X_merge[, mean_std_features] 

# Use descriptive activity names to name the activities in the data set
# Appropriately label the data set with descriptive activity names

names(X_mean_std) <- features[mean_std_features, 2] 
names(X_mean_std) <- gsub("\\(|\\)", "", names(X_mean_std)) 

activities <- read.table("activity_labels.txt")
activities[, 2] = gsub("_", " ", activities[, 2])
y_merge[,1] = activities[y_merge[,1], 2]
names(y_merge) <- "Activity" 

names(subject_merge) <- "Subject" 

# Merge the three datasets

final_data <- cbind(subject_merge, y_merge, X_mean_std) 
write.table(final_data, "final_data.txt") 

# Create a 2nd, independent tidy data set with the average of each variable for each activity and each subject

uniqueSubjects = unique(subject_merge)[,1] 
numSubjects = length(uniqueSubjects) 
numActivities = length(activities[,1]) 
numCols = dim(final_data)[2] 
result = final_data[1:(numSubjects*numActivities), ] 

row = 1 
for (s in 1:numSubjects) { 
    for (a in 1:numActivities) { 
        result[row, 1] = uniqueSubjects[s] 
        result[row, 2] = activities[a, 2] 
        temp <- final_data[final_data$Subject==s
                                   & final_data$Activity==activities[a, 2], ] 
        result[row, 3:numCols] <- colMeans(temp[, 3:numCols]) 
        row = row+1 
    } 
} 
write.table(result, "final_data_with_averages.txt", row.name=FALSE) 
