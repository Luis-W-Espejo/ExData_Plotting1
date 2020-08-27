################################## Coursera ##################################-
########################### Exploratory Data Analysis ########################-

# Luis W. Espejo

# Week 1: Project Course
# Setting Workspace
setwd("C:/Users/Willian Espejo/Desktop/Coursera")

#Calling basic library
library(dplyr)
library(lubridate)

# Downloading the data

url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
file <- "exdata_data_household_power_consumption.zip"
path <- "Household Power Comsumption"

#Checking if data is already downloaded
if (!file.exists(file)) {
    download.file(url, file, mode = "wb")
}
#Unzipping if it's not unziped
if (!file.exists(path)) {
    unzip(file, exdir=path)
}

# Reading the data
powerConsumption <- read.table(paste0(path,"/household_power_consumption.txt"),
                               header=T, sep=";", na.strings = "?")

# Formating the dates
powerConsumption$Date <- as.Date(powerConsumption$Date,format = "%d/%m/%Y")

# Subsetting the dataframe
powerConsumption <- powerConsumption %>%
    filter(Date==ymd("2007-02-01") | Date==ymd("2007-02-02"))

# Mergind data and time
powerConsumption$Datetime <- strptime(paste(powerConsumption$Date, 
                                            powerConsumption$Time, 
                                            sep=" "), 
                                      format = "%Y-%m-%d %H:%M:%S")

# Creating the graph
png(filename="plot2.png", height = 480, width = 480, bg="transparent", units="px")
with(powerConsumption, plot(Datetime, Global_active_power, 
                            type="l", 
                            xlab="", 
                            ylab="Global Active Power (kilowatts)"))
dev.off()

