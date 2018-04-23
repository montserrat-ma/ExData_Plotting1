library(readr)
library(lubridate)
library(dplyr)

#Reading data
filename<-"household_power_consumption.txt"
household <- read_delim(filename, ";", na = "?")
household$Date<-dmy(household$Date)

#Selecting the subset of the data to be analyzed
household2d <- household %>%
    filter(Date=="2007-02-01" | Date=="2007-02-02")
household2d$DateTime <- with(household2d,Date + Time)

#plot1
png(file = "plot1.png", width = 480, height = 480)
hist(household2d$Global_active_power,col="red",xlab="Global Active Power (kilowatts)",main="Global Active Power")
dev.off()
