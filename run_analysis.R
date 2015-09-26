##
## This R script will read in the Human Activity Recogintion Using smartphones data set as defined in the course project
##
library(dplyr)
##
## Step 1: Merge the training and test sets
##

## read column names and transform to replace non supported characters (e.g."-" is replaced by "_") and make sure they are unique
col_names <- read.table("UCI HAR Dataset/features.txt",sep="")
n1 <- col_names[,2]
n1 <- gsub("\\-","_",n1)
n1 <- gsub("\\)","_",n1)
n1 <- gsub("\\(","",n1)
n1 <- sub("__","_",n1)
unique_col_names <- make.names(n1,unique=TRUE)

## read relevant data sets from the training directory
training_set <- read.table("UCI HAR Dataset/train/X_train.txt",sep="",col.names = unique_col_names)
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt",sep="", col.names = "subject")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt",sep="", col.names = "Label_No")

## generate one data set of all training data i.e. subject, activity, ... measures
training_set <- cbind(subject_train,y_train,training_set)

## read relevant data sets from the test directory
test_set <- read.table("UCI HAR Dataset/test/X_test.txt",sep="",col.names = unique_col_names)
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt",sep="", col.names = "subject")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt",sep="", col.names = "Label_No")

## generate one data set of all test data i.e. subject, activity, ... measures
test_set <- cbind(subject_test,y_test,test_set)

## merge training and test data
observations=rbind(training_set,test_set)

##
## Step 2: Extract only the mean and standard deviation (Note that I only consider those Columns that 
## where including "mean()" or "std()" in the raw given data set as such)
##
sub_obs <- select(observations, matches('subject|Label_No|_mean_|_std_',ignore.case=TRUE))
##
## Step 3: use descriptive activity names. 
##
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt",sep="", col.names = c("Label_No","activity"))
sub_obs <- merge(sub_obs, activity_labels, by="Label_No", all.x = TRUE)
sub_obs <- select(sub_obs, -(Label_No))
##
## Step 4: give descriptive variable names
##
names(sub_obs) <- sub("^t","Time_",names(sub_obs))
names(sub_obs) <- sub("^f","Frequency_",names(sub_obs))
names(sub_obs) <- sub("_$","",names(sub_obs))
##
## Step 5: create tidy data set with the average of each variable
##
result <- sub_obs %>% group_by(subject, activity) %>% summarise_each(funs(mean))
write.table(result,"result.txt", row.name=FALSE)
