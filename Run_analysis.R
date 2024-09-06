run_analysis <- function(){
    ## Hey, thanks for reviewing my assignment - R.C. Kiwi
    
    ## The assignment instructions refer to five tasks it expects this script to
    ## perform as 'steps.' To make reading this script easier, I will do the 
    ## same in my comments and highlight each task as 'Step One' etc., hopefully
    ## making grading easier. 
    
    ## First, we need to get the data. 
    if (!dir.exists("cleaningproj")) {
        dir.create("cleaningproj")}
    wd <- getwd()
    wd <- paste(wd, "/cleaningproj", sep ="")
    setwd(wd)
    fileUrl <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(fileUrl, destfile = "./c3w4projdata.zip", method = "curl")    
    
    ## Next we will unzip the file
    zipF<- "./c3w4projdata.zip"
    unzip(zipF, exdir=wd)
    wd <- paste(wd, "/UCI HAR Dataset", sep ="")
    setwd(wd)
    ## Next let's call some libraries
    library(data.table)
    library(reshape2)
    library(dplyr)
    
    ## Let's go ahead and load all the data we will need.
    act_labels <- read.table("activity_labels.txt")
    featinfo <- read.table("features.txt")    
    
    sub_test <- read.table("test/subject_test.txt")
    y_test <- read.table("test/y_test.txt")
    x_test <- read.table("test/X_test.txt")
    
    sub_train <- read.table("train/subject_train.txt")
    y_train <- read.table("train/y_train.txt")
    x_train <- read.table("train/X_train.txt")
    
    ## combining data from files to create Data Tables.
    
    ## STEP FOUR
    ## Appropriately labels the data set with descriptive variable names. 
    ## It seems easier to do this at the beginning when first constructing the
    ## tables. 
  
    feat_names <- featinfo[,2]
    feat_names <- gsub("\\()", "", feat_names)
    feat_names <- gsub("\\-", "_", feat_names)
    ## Not sure if this is necessary but removing these parenthesis
    ## makes debugging and avoiding typos easier
    colnames(x_test) <- feat_names
    dt_test <- data.table(sub_test, y_test, set=rep("test", each=2947), x_test)
    colnames(dt_test)[1] <- "subject"
    colnames(dt_test)[2] <- "activity"
    
    colnames(x_train) <- feat_names
    dt_train <- data.table(sub_train, y_train, set=rep("train", each=7352), x_train)
    colnames(dt_train)[1] <- "subject"
    colnames(dt_train)[2] <- "activity"
    
    ## Originally added a 'set' column telling me which data set a row came from
    ## which i figured may be useful in debugging. I should've repeated the data
    ## for 'set' column in a more agnostic way using length(), but I got lazy.
    ## I should probably take this out but at this point I'm worried its going  
    ## to break something. 
    
    ## STEP ONE
    ## Merges the training and the test sets to create one data set
    
    dt_study <- rbind(dt_train, dt_test)
    
    ## STEP TWO 
    ## Extracts only the measurements on the mean and standard deviation for 
    ## each measurement. 
    ext <- grep("mean_", colnames(dt_study))
    ext1 <- grep("std", colnames(dt_study))
    ext2 <- c(1:2, ext, ext1)
    dt_selected <- select(dt_study, all_of(ext2))
     
    ## It was unclear to me whether the assignment wanted the "meanFreq()" 
    ## measures in addition to the "mean()" elements. If these WERE indeed 
    ## wanted, the line above could be 'ext <- grep("mean", colnames(dt_study))'
    ## The current code is written to exclude the "meanFreq()" elements.     
    
    dt_selected <- transform(dt_selected, tBodyAcc_mean_X = 
                                 as.numeric(tBodyAcc_mean_X))
    ## when debugging this, this column was a character vector. Not sure why,
    ## when coercing, there were no NA values. Couldn't reproduce. Will 
    ## probably take this out. 
    
    ## STEP THREE
    ## Uses descriptive activity names to name the activities in the data set
    for (i in 1:6) {
         dt_selected$activity <- gsub(act_labels[i,1], act_labels[i,2],
                                 dt_selected$activity)
    }
    ## Probably an easier way to do this with the libraries highlighted in this
    ## course, but this works. 
    dt_selected$activity <- tolower(dt_selected$activity)
    ## everything else is lowercase, might as well match.
    
    ## STEP FIVE
    ## From the data set in step 4, creates a second, independent tidy data set
    ## with the average of each variable for each activity and each subject.
    ext3 <- grep("mean", colnames(dt_selected))
    ## ext4 <- grep("std", colnames(dt_selected))
    sel_col <- colnames(dt_selected[,..ext3])
    ## I declined to include a mean of the "std()" elements by activity and 
    ## subject. I think the way the question is worded many people might include
    ## those elements, but it seems like a very bad habit to assume the mean of 
    ## a collection of standard deviations is going to be a meaningful value.
    ## If std is required, I would add ext4. 
    
    dt_selected <- dt_selected[,sub_activity:= paste(subject, 
                                                     activity, sep = "_")]
    for (i in 1:10299) {
        if (dt_selected[i,1]<10) {
            dt_selected[i,60] <- paste("0", dt_selected[i,60], sep ="")
        }
    }
    ## This may make this easier to read.
    
    mel_dt <- melt.data.table(dt_selected, id.vars = "sub_activity",
                              measure.vars = sel_col)
    dt_mean <- dcast(mel_dt, sub_activity ~ variable, mean)
    return(dt_mean)
    ## Initially, I assumed the best product would be an array of 
    ## 24 tables, each containing the mean for each subject for each activity 
    ## for a specified measure in the data set. This would be congruent with the
    ## principle of tidy-data that holds each table should be about one kind of
    ## observation. Reading some of the discussions before submitting this, 
    ## however, it looks like a single table would be the most useful product 
    ## for a hypothetical recipient of this data set. 
    
}