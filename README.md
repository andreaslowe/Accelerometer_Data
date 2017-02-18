# Data Cleaning Script
Script for tidying the accelerometer study data for the Coursera Data Cleaning Project

## NOTE: The script will run as is, with no input needed, as long as the UCI HAR Dataset folder is in the working directory.

## The script (run_analysis.R) pulls in data, if stored in the working directory, that was collected from the accelerometers in Samsung Galaxy S smartphones (linked to from the course website), and prepares a tidy data set which is output to a text file named "Tidy_Data_Accelerometer". This is done with the following steps:

## 1. Reading in the data - comprised of two text files in train and a test folders, along with the labels for the activity performed, and subject ids (there were 30 subjects). 
## 2. Add columns with the subject id and activity to the data sets
## 3. Identifiy and extract only the columns which contain either the mean or standard deviations for the given measurements (using a string search for these terms)
## 4. Merge the "test" and "train" data sets
## 5. Create the tidy data set which contains the average of each variable for each activity and subject (using the dylyr library)
## 6. Write the tidy data set to a text file


