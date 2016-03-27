# Getting abd Cleaning Data Course Project
## by David Garrido

This is the final course project for the Coursera course "Getting and Cleaning Data". This repository contains:
* The script <`run_analisys.R`>.
* The codebook where all transformations and additional information concerning this project is included.
* The final tidy dataset (tidyData.txt).

The script <`run_analisys.R`> does the following:

1. Loads the necessary datasets (activity labels, features, X_train, X_test, y_train and y_test).
2. Rename the columns in each dataset.
3. Keeps only measurements related to mean and standard deviations.
4. Identify activity labels in y_test and y_train.
5. Joins the test and training datasets into one dataset.
6. Creates a new dataset with the mean of each variable for each activity and each subject and saves it into <`tidyData.txt`>.
