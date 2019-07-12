
# setup and file load -----------------------------------------------------
library(tidyverse)
library(lubridate)

#checks if data-folder exists, if not, create it
if(!file.exists("data")){dir.create("data")} 

#check if file is already downloaded and extracted the file, if not, do and clean
if(!file.exists("./data/household_power_consumption.txt")) { 
        fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download.file(fileURL, "./Data/Power.zip")
        unzip("./data/Power.zip", exdir = "./data")
        file.remove("./Data/Power.zip")
        rm(fileURL)
}

#reads it into a tibble
power <- read_delim("./data/household_power_consumption.txt", delim = ";", na = "?")

#convert dates from character strings, using lubridate
power$Date <- dmy(power$Date)

#filter out the days we wanna plot
power <- filter(power, Date ==  "2007-02-01" | Date ==  "2007-02-02")

# plot --------------------------------------------------------------------
png(filename = "Plot4.png", width = 480, height = 480)
par(mfrow=c(2,2))
#topleft
<<<<<<< HEAD
with(power, plot(datetime, Global_active_power, xaxt = "n", type =  "l", ylab = "Global Active Power", xlab=""))

#topright
with(power, plot(datetime, Voltage, type =  "l", ylab = "Voltage", xlab="datetime"))

#bottomleft
with(power, plot(datetime, Sub_metering_1, type =  "l", ylab = "Energy sub metering", xlab=""))
lines(power$datetime, power$Sub_metering_2,type = "l", col="red")
lines(power$datetime, power$Sub_metering_3,type = "l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),lty = 1, col=c("black", "red", "blue"))

#bottomright
with(power, plot(datetime, Global_reactive_power, type =  "l", ylab = "Global Reactive Power",xlab="datetime"))
=======
plot(power$Global_active_power, xaxt = "n", type =  "l", ylab = "Global Active Power")

#topright
plot(power$Voltage, xaxt = "n", type =  "l", ylab = "Voltage")

#bottomleft
plot(power$Sub_metering_1, xaxt = "n", type =  "n", ylab = "Energy sub metering")
lines(power$Sub_metering_1, col="black")
lines(power$Sub_metering_2, col="red")
lines(power$Sub_metering_3, col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),lty = 1, col=c("black", "red", "blue"))

#bottomright
plot(power$Global_reactive_power, xaxt = "n", type =  "l", ylab = "Global Reactive Power")
>>>>>>> 05cbf8c53bfeedb317de426eae27ab73ee631848

dev.off()
