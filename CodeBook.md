# Getting and Cleaning Data Course Project
## by David G.R.

##Project Description:

In this project we will work with raw data to make it tidy and understandable and allowing 
anyone interesed to reproduce this work.

## Study Design and Data Processing:

### Collection of the Raw Data:

The data we are going to work with can be downloaded from:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The dataset corresponds to a series of experiments related to human activity recognition using 
smartphones. In the experiments, a group of 30 people carried out 6 activities (WALKING, 
WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone 
(Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope,
3-axial linear acceleration and 3-axial angular velocity at a constant rate 
of 50Hz were captured. The obtained dataset was randomly partitioned into two sets, 
where 70% of the volunteers was selected for generating the training data and 30% the 
test data.
Starting from the raw data (signals measured from the accelerometer and gyroscope) the 
authors applyed several transformations and filters to obtain the features we are going to 
work with.


### Notes on the Original (Raw) Data:

In order to work easily with the data, the files used were reorganized so they all have
the same path. The files used are:

* activity_labels.txt: Contains the numeric labels given to the different activities carried out.
* features.txt: Contains the numeric labels given to the features obtained by the authors.
* X_test.txt: Contains the data from the observed features for diferent activities carried
out by the subjects in the test group.
* subject_test.txt: Contains a vector of subject labels given to the subjects chosen to be part 
of the test set and ables to relate the observations in "X_test.txt" to a certain subject.
* y_test.txt: Contains a vector of activity labels to the activities carried out and ables 
to relate the observations in "X_test.txt" to a certain activity.
* X_train.txt: Contains the data from the observed features for diferent activities carried
out by the subjects in the train group.
* subject_train.txt: Contains a vector of subject labels given to the subjects chosen to be part 
of the train set and ables to relate the observations in "X_train.txt" to a certain subject.
* y_train.txt: Contains a vector of activity labels to the activities carried out and ables 
to relate the observations in "X_train.txt" to a certain activity.

## Creating the Tidy Dataset:

1. Download the data.
2. Load the packages plyr and dplyr.
3. Load the datasets required (View Note on the Original Data).
4. Rename measurements in dataframes. 
	* X_test and X_train (dimensions 2947x561 and 7352x561 respectively) contain the data on 
	the different features measured and its names are contained in the second column of the 
	features table (dimensions 561x2).
	* y_test and y_train (dimensions 2947x1 and 7352x1) contain a vector of activity labels, so
	it is possible to identify each row in X_test and X_train with a particular activity.
	* subject_test and subject_train (dimensions 2947x1 and 7352x1) contain a vector of subject
	labels, so it is possible to identify each row in X_test and X_train with a particular subject.
5. Keep only mean and standard deviation features. Using regular expressions and <`grep`> we can keep
only measurements with "mean", "Mean" or "std" in its name in X_test and X_train.
6.Merge test and training set to create a dataset. Since there are no repeated information in the 
datasets we have only to join the data sets together. On one side we form the test and training datasets
with binding x, y and subject columns. Later we bind the rows of both datasets.
7. Label the dataset with descriptive names. The variables in the complete dataset are correctly labeled
but some names are not descriptive. Observing the names we decided to substitute (using <`gsub`>):
	* "t" for "time".
	* "f" for "frequency".
	* "Acc" for "Accelerometer".
	* "Gyro" for "Gyroscope".
	* "Mag" for "Magnitude".
	* "BodyBody" for "Body".
8. From the dataset, create a second tidy dataset with the average of each variable for each activity
and each subject. This step can be easily done with <`aggregate(. ~subject+activity, dataset, mean)`>. 
The resulting dataset contains the mean of each variable sorted by activity and subject, so no ordering
is required. To finish, we save the last dataset into a txt file.
