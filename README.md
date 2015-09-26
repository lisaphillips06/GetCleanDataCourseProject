# Coursera Getting and Cleaning Data Course Project 

This code creates a tidy data set out of the UCI HAR dataset. The dataset includes data from an experiment carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, the authors captured data points about the people moving.

More explanation of the study design can be found at: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

#Explanation of the run_analysis.R code to clean the data 

The code first reads all files into R associated with the experiment. There were two sets of data: training and testing data. Each set had 3 files associated with the experiment: subject identifiers, activity identifiers, and features measurements.  

The code cuts the features training and test datasets down to only include columns with Mean and Standard Deviation measurements.  

It then changes the column names of the datasets to match the Features being measured. I.e. a column previously named X3 might be renamed to accurately show the feature being measured (e.g. tBodyAcc-mean()-X).

It merges subject and activity identifiers into each of the train and test datasets. 

It merges the train and test datasets together, and adds in descriptive names of the activities performed.  

It then takes the average of each feature by activity and subject, and outputs the data into a file named tidydata.txt 





