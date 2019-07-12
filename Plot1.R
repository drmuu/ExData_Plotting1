
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
power$Time <- hms(power$Time)

#filter out the days we wanna plot
power <- filter(power, Date ==  "2007-02-01" | Date ==  "2007-02-02")

# create plot -------------------------------------------------------------
png(filename = "Plot1.png", width = 480, height = 480)
hist(power$Global_active_power,
        col="red",
        main = "Global Active Power",
        xlab = "Global Active Power (kilowatts)"
     )
dev.off()
