## Exploratory Data Analysis--Project 1 Plot 2

library(sqldf)
## load the filtered file
data <- read.csv.sql("./household_power_consumption.txt",                   
                sql = "select * from file where Date = '1/2/2007' 
                or Date = '2/2/2007'", sep = ';', header =TRUE, row.names = NULL,
                colClasses = "character")

## change variable to numeric
y<- as.numeric(data$Global_active_power)
## read in date/time info in format 'd/m/y h:m:s'
dates <- data$Date
times <- data$Time
datetime <- paste(dates, times, sep = " ")
x <-strptime(datetime, "%d/%m/%Y %H:%M:%S")


## create plot
plot(x,y, type = "l",xlab = "", ylab ="Global Active Power (kilowatts)")

##copy to png file
dev.copy(png,file="Plot2.png",width=480,height = 480)

## close device
dev.off()
