library(readr)
library(lubridate)
library(dplyr)

# English words for the weekday abbreviation
curr_locale <- Sys.getlocale("LC_TIME")
Sys.setlocale("LC_TIME","en_US.UTF-8")

#Reading data
filename<-"household_power_consumption.txt"
household <- read_delim(filename, ";", na = "?")
household$Date<-dmy(household$Date)

#Selecting the subset of the data to be analyzed
household2d <- household %>%
    filter(Date=="2007-02-01" | Date=="2007-02-02")
household2d$Time <- hms(household2d$Time)
household2d$DateTime <- with(household2d, Date + Time)

#plot3
png(file = "plot3.png", width = 480, height = 480)
plot(household2d$DateTime,household2d$Sub_metering_1,type="l",xlab="",ylab="Energy sub metering")
lines(household2d$DateTime,household2d$Sub_metering_2,col="red")
lines(household2d$DateTime,household2d$Sub_metering_3,col="blue")
legend("topright",lty=1,col=1:3,legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.off()

#Back to the original wording
Sys.setlocale("LC_TIME",curr_locale)
