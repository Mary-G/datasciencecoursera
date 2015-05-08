## Exploratory Data Analysis--Project 1 Plot 4

library(sqldf)
## load the filtered file
data <- read.csv.sql("./household_power_consumption.txt",                   
                sql = "select * from file where Date = '1/2/2007' 
                or Date = '2/2/2007'", sep = ';', header =TRUE, row.names = NULL,
                colClasses = "character")

## Set up 2 by 2 grid
par(mfcol = c(2,2))
par(mar = c(4,4,2,2))

## Graph 1
## change variable to numeric
y<- as.numeric(data$Global_active_power)
## read in date/time info in format 'd/m/y h:m:s'
dates <- data$Date
times <- data$Time
datetime <- paste(dates, times, sep = " ")
x <-strptime(datetime, "%d/%m/%Y %H:%M:%S")


## create plot
plot(x,y, type = "l",xlab = "", ylab ="Global Active Power (kilowatts)")


## Graph 2
## change variable to numeric
y1<- as.numeric(data$Sub_metering_1)
y2<- as.numeric(data$Sub_metering_2)
y3<- as.numeric(data$Sub_metering_3)


## create plot
plot(x,y1, type = "n",xlab = "", ylab ="Energy sub metering")
points(x,y1, type = "l",col = "black")
points(x,y2, type = "l",col = "red")
points(x,y3, type = "l",col = "blue")

legend("topright", pch = NA, lty = c(1,1,1), lwd = 2, col = c("black","red","blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
        text.col = c("black","red","blue"), cex=0.5)

## Graph 3
## create plot
y4 <- as.numeric(data$Voltage)
plot(x,y4, type = "l",xlab = "datetime", ylab = "Voltage")

## Graph 4
## create plot
y5 <- as.numeric(data$Global_reactive_power)
plot(x,y5, type = "l",xlab = "datetime", ylab = "Global_reactive_power")

##copy to png file
dev.copy(png,file="Plot4.png",width=480,height = 480)

## close device
dev.off()
