##  R script that:
#   1.Merges the training and the test sets to create one data set.
#   2.Extracts only the measurements on the mean and standard deviation for each measurement. 
#   3.Uses descriptive activity names to name the activities in the data set
#   4.Appropriately labels the data set with descriptive variable names. 
#
#   5.From the data set in step 4, creates a second, independent tidy data set with the average 
#      of each variable for each activity and each subject.  To do this need to install and load
#      the reshape library.

library(reshape)

#
# Note:  This script runs from the same directory as the the data files
#
# Read the column titles
  features <- read.table ("features.txt")
# Read the activity labels
  acttable <- read.table ("activity_labels.txt")
# Define the test data file names
 testfilename <- c("X_test.txt")
 subtestfilename <-c("subject_test.txt")
 acttestfilename <-c("y_test.txt") 
#
# Define the training data file names
 trainfilename <- c("X_train.txt")
 subtrainfilename <- c("subject_train.txt")
 acttrainfilename <-c("y_train.txt")
#
#build the test data file - subject, activity, then data.  cbind them together.
 testdat <- read.table(testfilename, col.names = features [,2])
 actdat <- read.table(acttestfilename, col.names= "Activity")
 subdat <- read.table(subtestfilename, col.names= "Subject")
 testdat <- cbind(subdat, actdat, testdat)
#
#build the training data the same way, then rbind them into a single file "dat".
 traindat <- read.table(trainfilename, col.names = features [,2])
 actdat1 <- read.table(acttrainfilename, col.names= "Activity")
 subdat1 <- read.table(subtrainfilename, col.names= "Subject")
 traindat <- cbind(subdat1, actdat1, traindat)
#
 dat <- rbind(testdat,traindat)

 # replace index with activity name
 dat[,2] <- acttable[dat[,2],2]
 
# extract only means and standard deviations - check for strings "mean" or "std" in variable name
 datsum <- dat[,grepl("mean",colnames(dat))|grepl("std",colnames(dat))]
 datsum <- cbind(dat[,1:2],datsum)

 
#  Now, create a second tidy data set from dat - means of mean and std variables from each subject and each activity
 molten_dat <- melt(datsum, id=c("Subject","Activity")) 
 cast_dat <- cast(molten_dat, Subject + variable ~ Activity,mean)
 write.table(cast_dat,"proj3output.txt",row.names=FALSE)
