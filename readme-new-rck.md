README

title: "Getting and Cleaning Data Course Project Read Me"
author: "RC-Kiwi, aka Robert Keely"
date: "2024-08-26"
---

The script will download, unzip, process and clean the data. Within the function there are some notable data tables.

**dt_study** is a complete set of all 561 features measured and calculated time and frequency domain variables. It combines observations from the training set and the test set. This specific table is not requested, but prepared with a separate script for de-bugging purposes. 

**dt_selected** is a Data Table of the mean() and std() features for each features for each observation.

The only table that is returned, however is the following:

**dt_mean** is a Data Table containing a mean across all the means() of each category of variable across multiple observations separated by activity and by subject. 

run_analysis.R  works the following way: 

 - First, the script will download the data from a  URL after checking to see if the targeting directory exists, and creating it if not. 
 - The script will change to working directory to get to unzipped files.
 - Next the script then unzip the file
 - Next the script loads all the data we will need. 
 -- This includes a set of 561 element vectors from "X_train.txt" and "X_test.txt", 
 -- the column names of the elements for the 561 feature vector for each observation from "features.txt", 
 -- a column of subject identifiers matching an observation to a subject from "subject_test.txt" and "subject_train.txt", 
 -- and a column of activity identifiers from "y_train.txt" and "y_test.txt"
 - Next a single data frame will be created from binding the columns together, then joining train and test data together
 - And then, the names of each activity are substituted for the numeric designation in the column of activity identifiers.

 - The second section takes the data table dt_study from the first section and runs the function grep with the Regular Expressions to find the columns of dt_study that contain the string "mean()" and "std()". 
  - These columns, along with the the columns for activity and subject, are used to create the data table dt_selected. 
  
 - The third and final section handles the fifth objective from the assignment. To make running the following part easier, another column is created so that each activity for each subject can be used as a factor. It then uses the 'melt()' and 'dcast()' to get the means for each of the selected elements and use it to create the data table 'dt_mean'. It then returns 'dt_mean.'
