# DataCleaningProject
## Introduction
This repository includes the required R script run_analysis.R and the code book to explain the parameters of the tidy parameters.
## Script explanation
###prerequisites
The scripts assumes that the working directory includes a directory "UCI HAR Dataset" that includes all expanded raw data files (respectively in thesub directories test and training)
### detailed steps
This R script will read in the Human Activity Recogintion Using smartphones data set as defined in the course project

####Step 1: Merge the training and test sets
* First the read column names are read and transformed to replace non supported characters (e.g."-" is replaced by "_") 
and make sure they are unique
* read relevant data sets from the training directory (X_train.txt, subject_train.txt, y_train.txt)
* generate one data set of all training data i.e. subject, activity, ... measures
``training_set <- cbind(subject_train,y_train,training_set)``
* read relevant data sets from the test directory (X_test.txt, subject_test.txt, y_test.txt)
* generate one data set of all test data i.e. subject, activity, ... measures
test_set <- cbind(subject_test,y_test,test_set)
* merge training and test data by means of rbind

#### Step 2: Extract only the mean and standard deviation 
(Note that I only consider those Columns that where including "mean()" or "std()" in the raw given data set as such

#### Step 3: use descriptive activity names by merging in the activity names from file activity_labels.txt

#### Step 4: give descriptive variable names
Following descriptive naming is applied for the column names:
starting with either "Time_" or "Frequency_" to indicate whether it is a time domain signal or frequency domain signal, 
followed by a feature indication e.g. "BodyAcc, and then followed by the indication whether the mean or std was estimated from the signal, and last but not least the direction indication X,Y or Z if appropriate.

#### Step 5: create tidy data set 
Create a tidy data set with the average of each variable grouped by subject and activity 
and write to the file "result.txt
