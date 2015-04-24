## Load the files into the environment
x_test <-read.table("./UCI HAR Dataset/test/x_test.txt",header = FALSE)
y_test <-read.table("./UCI HAR Dataset/test/y_test.txt",header = FALSE, col.names = "Activity")
subject_test <-read.table("./UCI HAR Dataset/test/subject_test.txt",header = FALSE,
                          col.names = "Subject")

x_train <-read.table("./UCI HAR Dataset/train/X_train.txt",header = FALSE)
y_train <-read.table("./UCI HAR Dataset/train/y_train.txt",header = FALSE, col.names = "Activity")
subject_train <-read.table("./UCI HAR Dataset/train/subject_train.txt",header = FALSE,
                          col.names = "Subject")

features <- read.table("./UCI HAR Dataset/features.txt",header = FALSE)
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt",header = FALSE, 
                              colClasses = "character")
library(Rcpp)
library(plyr)
library(dplyr)
library(tidyr)
library(reshape)

## Merge test and train datasets
x_set <- bind_rows(x_test,x_train)
y_set <- bind_rows(y_test,y_train)
subject_set <- bind_rows(subject_test,subject_train)

## Add column names
colnames(x_set) <- features[1:ncol(x_set),"V2"]

## Merge columns
data <- bind_cols(subject_set,y_set,x_set)

## Remove duplicated columns & then keep only mean and standard deviation measures
data <- data[!duplicated(names(data))]
data2 <- select(data,Subject,Activity,matches("-mean()", ignore.case = TRUE),
                matches("-std()", ignore.case = TRUE),
                -matches("gravityMean", ignore.case = TRUE),
                -matches("meanFreq", ignore.case = TRUE))

## Join in the activity names
names(activity_labels) <- c("Activity","Activity_Name")

data3 <- arrange(join(data2,activity_labels),Activity)

## Rearrange columns
data4 <- select(data3,Subject,Activity,Activity_Name,3:68)

## Average of each variable for each activity and each subject
data_mean <- ddply(data4,.(Subject,Activity,Activity_Name),colwise(mean))

## Export data_mean
write.table(data_mean,file = "data.mean.txt", col.names =  TRUE, row.name=FALSE)