## temp file
temp <- tempfile()
## file location to unzip
directory <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(directory,temp)
## unzip files
filelist <- unzip(temp,overwrite = TRUE)
unlink(temp)

##unzip(directory,overwrite = TRUE, exdir = "./data")

