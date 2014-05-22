clean_data_project
==================

This script reads the processed train and the test data each into single data frame
Then each data drame is labeled with the feature names as column names.
The two data frames are then combined into single one based on the common column names.
Then a new subset data frame is built with extracted feature names containg only mean and standard deviation estimates.
A factor vector is created with the true activity names and then it is used to replace the corresponding column it the data frame.
The data frame is then reshaped and summarized so that the mean of each measurement for each patient and activity is obtained.
Finally it is stored into a clean single data set as a .txt file.
