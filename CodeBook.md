---
title: "CodeBook"
output: html_document
---

Peer-graded Assignment: Getting and Cleaning Data Course Project

The original data was transformed by:

  (1) Merges the training and the test sets to create one data set.

  (2) Extracts only the measurements on the mean and standard deviation for each measurement.

  (3) Uses descriptive activity names to name the activities in the data set

  (4) Appropriately labels the data set with descriptive variable names.

  (5) From the data set in step 4, creates a second, independent tidy data set with the average of each variable    for each activity and each subject.

About R script:
  File with R code "run_analysis.R" perform 5 steps above.

About variables:
  x_train, y_train, x_test, y_test, subject_train and subject_test contain the data from the downloaded files.

  x, y and subject merge the previous datasets to further analysis.

  Features contains the names for the x_data dataset.
