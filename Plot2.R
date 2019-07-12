
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
<<<<<<< HEAD
power <- power %>% 
        filter(between(Date, as_date("2007-02-01"), as_date("2007-02-02")))  %>%
        mutate(datetime = paste(as.character(Date), Time, sep = " ")) %>%
        mutate(datetime = as.POSIXct(datetime, tz = Sys.timezone()))

# plot --------------------------------------------------------------------
png(filename = "Plot2.png", width = 480, height = 480)
with(power, plot(datetime, Global_active_power, type =  "l", ylab = "Global Active Power (kilowatts)"))
=======
power <- filter(power, Date ==  "2007-02-01" | Date ==  "2007-02-02")

# plot --------------------------------------------------------------------
#Here I fail to plot the weekday names on the x-axis. Please give hints if you managed! 
png(filename = "Plot2.png", width = 480, height = 480)
plot(power$Global_active_power, xaxt = "n", type =  "l", ylab = "Global Active Power (kilowatts)")
>>>>>>> 05cbf8c53bfeedb317de426eae27ab73ee631848
dev.off()
