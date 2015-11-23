# Getting-and-Cleaning-Data

##This is for the Getting and Cleaning Data Coursera course project. The R script, run_analysis.R, does the following function:

###  1. Download and install the needed packages if they do not exist in the R environment
###  2. Download the dataset if it does not already exist in the working directory
###  3. The R script will automatically check, download and unzip the datasets
###  4. The R file will load the activity and feature info, keeping only those columns which reflect a mean or standard deviation
###  5. Then, the R file will Load the activity and subject data for each dataset, and merges those columns with the dataset
###  6. After that, it will merges the two datasets and converts the activity and subject columns into factors
###  7. At last, it will create a tidy dataset that consists of the average (mean) value of each variable for each subject and activity pair.