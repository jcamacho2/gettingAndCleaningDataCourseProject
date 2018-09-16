# gettingAndCleaningDataCourseProject
Submission for Getting and Cleaning Data course project on Coursera.

This program uploads data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
and converts it into a tidy dataframe with four columns: subject, activity, measurement, mean.

You must unzip the downloaded folder and set your working directory to be in the "UCI HAR Dataset" folder for run_analysis.R to work.

<h2> run_analysis </h2>

run_analysis reads the training set, the subject labels for the training set, and the activity labels for the training set. 

It then merges these dataframes using cbind to produce a data frame with 563 columns: subject, activity, V1, V2, ..., V561. Where V1:V561 represents the 561 features in each row. 
  
run_analysis does the same with the testing sest. Afterwards, the program merges the training and test sets with rbind to form one dataset.

It replaces V1:V561 with appropriate variable names derived from "features.txt". It replaces the values in the activity column with meaningful names, derived from "activity_labels.txt".

Then it, by using a regular expression, it selects only those features (columns) that are either a mean or standard deviation.
Finally it creates a tidy independent data set from the above data set using a series of for loops.

<h2> Code book </h2>
The code book describes the variables of the output file from run_analysis.R, "tidyData.txt".
