# Getting-and-Cleaning-Data

Course work for Getting and Cleaning Data course on Coursera

## Course Project

* Download and unzip the source data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip in a folder on your computer, say FOLDER

* Change your working directory to FOLDER/UCI HAR Dataset

* Put run_analysis.R in your working directory and run it. This script merges the training and test data sets, extracts only the measurements on the mean and standard deviation for each measurement, applies descriptive activity names and appropriate labels, and finally creates the output tidy data set with the average of each variable for each activity and each subject.

* Output file final_data_with_averages.txt will be created in your working directory. 1st column in the output file contains subject IDs, 2nd column contains activity, and columns 3 to 68 contain the averages for 66 variables. There are 30 subjects and 6 activities, so there are a total of 180 rows of data in this output file.

* Refer CodeBook.md for the description of the variables in the output file.