
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
power <- power %>% 
        filter(between(Date, as_date("2007-02-01"), as_date("2007-02-02")))  %>%
        mutate(datetime = paste(as.character(Date), Time, sep = " ")) %>%
        mutate(datetime = as.POSIXct(datetime, tz = Sys.timezone()))

# plot --------------------------------------------------------------------
png(filename = "Plot3.png", width = 480, height = 480)
with(power, plot(datetime, Sub_metering_1, type =  "l", ylab = "Energy sub metering"))
lines(power$datetime, power$Sub_metering_2,type = "l", col="red")
lines(power$datetime, power$Sub_metering_3,type = "l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),lty = 1, col=c("black", "red", "blue"))
dev.off()
