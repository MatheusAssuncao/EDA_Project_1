# Exploratory Data Analysis

# Course Project 1 - Graphic 3
library(dplyr)
library(lattice)

# Preparing the data to work
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
file1 <- download.file(url, destfile = "household_power_consumption.zip")
file2 <- unzip("household_power_consumption.zip")
classes <- c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", 
             "numeric", "numeric")
data <- read.table(file2, header = TRUE, sep = ";", dec = ".", na.strings = "?", colClasses = classes)

# Correcting dates 
data <- mutate(data, DateTime = paste(Date, Time))
data <- mutate(data, DateTime = as.POSIXct(DateTime, format = '%d/%m/%Y %H:%M:%S'))
data <- mutate(data, Date = as.Date(Date, format='%d/%m/%Y'))
data <- mutate(data, Time = as.Date(Time, format='%H:%M:%S'))

# Subsetting for the relevant dates
date1 <- as.Date("2007-02-01")
date2 <- as.Date("2007-02-02")
data <- data[data$Date >= date1 & data$Date <= date2,]
#data <- mutate(data, Day = weekdays(Date), abbreviate = TRUE)

# Making Graphic 3

png(file="plot3.png",
    width=480, height=480)
xyplot(data$Sub_metering_1 + data$Sub_metering_2 + data$Sub_metering_3 ~ data$DateTime, 
       , data=data, type = c('l','l','l'), col = c("black", "red", "blue")
       , auto.key = list(x = 0.66, y = 1, border = TRUE,lines = TRUE, points = FALSE),
       , scales = list(x=list(format="%a"))
       , ylab = "Energy sub metering", xlab = "")
dev.off()