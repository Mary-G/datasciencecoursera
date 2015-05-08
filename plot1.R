## Exploratory Data Analysis--Project 1  Plot 1

library(sqldf)
## load the filtered file
data <- read.csv.sql("./household_power_consumption.txt",                   
                sql = "select * from file where Date = '1/2/2007' 
                or Date = '2/2/2007'", sep = ';', header =TRUE, row.names = NULL,
                colClasses = "character")

## change variable to numeric
x<- as.numeric(data$Global_active_power)

## create histogram
hist(x,col = "red", main = "Global Active Power",xlab = "Global Active Power (kilowatts)")

##copy to png file
dev.copy(png,file="Plot1.png",width=480,height = 480)

## close device
dev.off()
