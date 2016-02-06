setwd("~/DataScience/Exploratory")


fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl,"./power.zip")
unzip("./power.zip")
list.files()

## Read in Data - Only Feb 1/2007 and Feb 2/2007.  
## File is large so skip irrelevant rows and only select the 2880 necessary rows.
power <- read.table("household_power_consumption.txt", 
                    skip = 66637, nrows=2880, sep=";", stringsAsFactors=FALSE)

##  Column names were dropped.  Add them back in with this code.
names <- read.table("household_power_consumption.txt", 
                    nrows=2, sep=";", header=TRUE, stringsAsFactors=FALSE)
library(data.table)
old1<-names(power)
new1<- names(names)

## Setting new names.
setnames(power, old=old1, new=new1)

## Concatenating the Date and Time
power$NewDate <- paste(power$Date, power$Time, sep=" ")
## Converting Date and Time to PosixLt
power$NewDate <- strptime(power$NewDate, "%d/%m/%Y %H:%M:%S")

## Chart4  4 Charts in 1.
png("plot4.png", width=480, height = 480)
##Splitting into 2 rows and 2 columns
par(mfrow=c(2,2))  

## Top Left 
##Global Active Power by Date time
plot(power$NewDate, power$Global_active_power, type="n", col="black", ylab="Global Active Power", xlab = '')
lines(power$NewDate, power$Global_active_power)

## Top Right
## Voltage by Date time
plot(power$NewDate, power$Voltage, type="n", 
     col="black", ylab="Voltage", xlab = 'datetime')
lines(power$NewDate, power$Voltage)

## Bottom Left
## Energy Sub Metering by Date Time
plot(power$NewDate, power$Sub_metering_1, type="n", ylab='Energy Sub Metering', xlab='')
lines(power$NewDate, power$Sub_metering_1, col="black")
lines(power$NewDate, power$Sub_metering_2, col="red")
lines(power$NewDate, power$Sub_metering_3, col="blue")
legend("topright", lty=c(1,1,1), col=c("black", "red", "blue"), 
       c("Sub Metering 1", "Sub Metering 2", "Sub Metering 3"))

## Bottom Right
## Global Reactive Power by Date Time
plot(power$NewDate, power$Global_reactive_power, type="n", 
     col="black", ylab="Global_reactive_power", xlab = 'datetime')
lines(power$NewDate, power$Global_reactive_power)


dev.off()

