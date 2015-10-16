---
title: "README for Getting and cleaning data course project"
output: html_document
---

This document explains the data, variables and transformations used in the run_analysis script and its output. The process is explained is numerical sequence corresponding to the tasks list on the assignemt. Namely:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Step 1:

The appropriate files are loaded into R and stored with variables names matching the corresponding file name. Then we use the cbind function to combine the subjects, the activities and the data. We use rbind to combine the test and training data into one large data set called "data". In the final part of step 1 we remove the temporary data variables from the workspace.

Step 2:

First we load the features from features.txt into an appropriately named variable. Notice that we specifically choose stringAsFactors = False as we would like to manipulate the strings as strings soon after.

Next we create a logical vector that indicates the position in features of description of means or standard deviations. Notice that we do not consider the variables marked meanfreq as this is a different statistic to mean.

We use the which function to give the position of such variables and then we use this to select only the columns corresponding to means and standard deviations.

Finally, we remove positions from the workspace. Notice that we do not remove features or good as we will need them again in step 4.

Step 3:

A function callen convert is defined that converts a number 1-6 into the relevant activity as described in activity_labels.txt. This function is then applied to the second column of data to replace the numbers with descriptive activity names.

Finally we remove the function from the workspace.

Step 4:

We assign meaningful column names by extracting the features directly from the features as created during step 2. Notice that we do not reformat these names. As the original data set does not provide any guidance to what these variables names actually mean.

Step 5:

We use the melt function from the reshape2 package to reshape the data so that we can use ddply to take the mean over all of the matching Subject, Activity, variable tuples.

Finally, we write the set of tidy data out as "tidy_output.txt" using write.table. We leave the data from step 4 and the tidy_data variables in the workspace so that further exploration and analysis can be done.

 


