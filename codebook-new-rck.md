title: "Getting and Cleaning Data Course Project Code Book"
author: "RC-Kiwi, aka Robert Keely"
date: "2024-09-04"
---
Dateset Provided Smartlab per publication by Anguita et al [1]
---
This tidydata package seeks to 

* Merge the training and the test sets to create one data set.

* Extracts only the measurements on the mean and standard deviation for each measurement. 

* Uses descriptive activity names to name the activities in the data set

* Appropriately labels the data set with descriptive variable names. 

* From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

---

The dataset contains ~330 observations each for 30 different study subjects, divided among six different acvtivities. The subjects were divided into a group of 21 for training data and 9 for testing data.

For each observation there is (1) a vector 561 features (contained in the file 'x_test/train'). 

There is also, for each observation, (2) raw inertial data for total acc, relative acc, angular velocity, measured for each of the x,y,z axises, measured 50 times a second over 2.56 seconds for total of 128 measured signals. This raw inertial data is not referenced in the spec-sheet for the desired tidy data (i.e. our assignment) and therefore  this code book will not discuss them further and they are not extracted in the script. 

--- 

What is a 'variable' and a 'measurement' in the instructions of the assignment provided on Coursera are somewhat vague in my opinion. To be fair, the original data codebook leaves a lot of room open to specifically refer-to or categorize the different types of features in the 561 element long vectors that are provided for each observation.

Going forward, for the second step I will interpret the first time 'measurement' is used to refer to the individual elements of the 561 feature long vector. The second time 'measurement' is used in that sentence, I will interpret that as the categories of measured and calculated data encomposed the frequency domain signal and time domain signal (t and f) for BodyAcc, GravAcc, BodyGyro, BodyAccJerk, BodyGyroJerk, domains in XYZ axes and magnitude. 

As there are 17 categories of measured and calculated data, I am expecting to get 17 mean values for each row (observation), and 17 standard deviations for each row (observation). Wait, 8 of those categories are repeated for three dimensions, so that would be 33 total mean values. There are 17 elements calculated from each category of data, and 33 * 17 = 561, so might cover all the elements. I'll just have to examine the data, I guess. 

In the fifth step we are asked to 'average' the each 'variable'. I am left to infer  'variable' in this context is the variable referenced in the fourth step as receiving descriptive names. This 'variable' is the data being extracted in the second step, the mean() of each category of measured and calculated data. I will assume 'average' is being used to refer to obtaining a mean, as that is the most common specific measure referred to as 'average.'

Below the thick line breaks is a summary of relevant information provided by original dataset's codebook. 

==================================================================

Human Activity Recognition Using Smartphones Dataset
Version 1.0

---

Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Universit‡ degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws

---

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

----

These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the prefix 'f' used to denote frequency domain signals). 

These signals were used to estimate values of the feature vector for each pattern. In summary the categories of measurements are as follows. 

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

(Note: '-XYZ' is used to denote 3-axial signals in the X, Y and Z directions)


The set of variables that were estimated from each of these signal 1 are: 

mean(): Mean value
std(): Standard deviation
mad(): Median absolute deviation 
max(): Largest value in array
min(): Smallest value in array
sma(): Signal magnitude area
energy(): Energy measure. Sum of the squares divided by the number of values. 
iqr(): Interquartile range 
entropy(): Signal entropy
arCoeff(): Autorregresion coefficients with Burg order equal to 4
correlation(): correlation coefficient between two signals
maxInds(): index of the frequency component with largest magnitude
meanFreq(): Weighted average of the frequency components to obtain a mean frequency
skewness(): skewness of the frequency domain signal 
kurtosis(): kurtosis of the frequency domain signal 
bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
angle(): Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

gravityMean
tBodyAccMean
tBodyAccJerkMean
tBodyGyroMean
tBodyGyroJerkMean

---

Notes: 
- Features are normalized and bounded within [-1,1].

--- 

1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

The data is currently located at the following URL. 
 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
