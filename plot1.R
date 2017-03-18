library(dplyr)

#Read in power data from text file
power <- read.table("household_power_consumption.txt", header = TRUE, na.strings = "?", sep = ";")

#Assign filename for .png output
png(filename = "plot1.png")

#Create date variable
power$dateOnly <- as.Date(power$Date, format = "%d/%m/%Y")

#Filter data for 1st two days of February 2007
power <- filter(power, dateOnly == as.Date("2007-02-01") | dateOnly == as.Date("2007-02-02"))

#Run histogram function to plot histogram of Global_active_power
hist(power$Global_active_power, col = "red", main = "", xlab = "", ylab = "")

#Define title for plot
title(main = "Global Active Power", xlab = "Global Active Power (kilowatts)", ylab = "Frequency")

#Close plot output file
dev.off()
