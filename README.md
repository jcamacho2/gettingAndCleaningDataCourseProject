# gettingAndCleaningDataCourseProject
Submission for Getting and Cleaning Data course project on Coursera.

--------------------------------------------------------------
The script was written on: 

R version 3.5.1 (2018-07-02) -- "Feather Spray"
Copyright (C) 2018 The R Foundation for Statistical Computing
Platform: x86_64-w64-mingw32/x64 (64-bit)

Windows 10 Version 1803

--------------------------------------------------------------

<h2> Instructions </h2>

This program uploads data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
and converts it into a tidy dataframe with four columns: subject, activity, measurement, mean.

You must unzip the downloaded folder and set your working directory to be in the "UCI HAR Dataset" folder for run_analysis.R to work.

<ol>
  <li>Download the data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip</li>
  <li>Unzip the folder and set your working directory to be in the "UCI HAR Dataset" folder</li>
  <li>Install and load the dyplyr package</li>
  <li>Run run_analyis</li>
</ol>

<h2> run_analysis </h2>

run_analysis reads the training set, the subject labels for the training set, and the activity labels for the training set. 

It then merges these dataframes using cbind to produce a data frame with 563 columns: subject, activity, V1, V2, ..., V561. Where V1:V561 represents the 561 features in each row. 
  
run_analysis does the same with the testing sest. Afterwards, the program merges the training and test sets with rbind to form one dataset.

It replaces V1:V561 with appropriate variable names derived from "features.txt". It replaces the values in the activity column with meaningful names, derived from "activity_labels.txt".

Then, by using a regular expression, it selects only those features (columns) that are either a mean or a standard deviation.
Finally, it creates a tidy independent data set from the above data set using a series of for loops.

<h2> code_book </h2>
The code book describes the variables of the output file from run_analysis.R, "tidyData.txt".
