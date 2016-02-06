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

##Chart2.  
##Line Chart of Global Active Power by date/time
png("plot2.png", width=480, height=480)
plot(power$NewDate, power$Global_active_power, type="n", col="black", ylab="Global Active Power (kilowatts)", xlab = '')
lines(power$NewDate, power$Global_active_power)
dev.off()