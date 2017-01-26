#Read in power data from text file
power <- read.table("C:\\Users\\Fujitsu\\Documents\\Kevy\\Exploratory Data Analysis\\Week 1\\household_power_consumption.txt", header = TRUE, na.strings = "?", sep = ";", stringsAsFactors = FALSE)

#Assign filename for .png output
png(filename = "C:\\Users\\Fujitsu\\Documents\\Kevy\\Exploratory Data Analysis\\Week 1\\plot2.png")

#Create date variable
power$dateOnly <- as.Date(power$Date, format = "%d/%m/%Y")

#Filter data for 1st two days of February 2007
power <- filter(power, (dateOnly == as.Date("2007-02-01") | dateOnly == as.Date("2007-02-02")) & !is.na(power$Global_active_power))

#Create date/time variable from Date and Time variables in power
power$dateAndTime <- as.POSIXct(paste(power$Date, power$Time), format = "%d/%m/%Y %H:%M:%S")

#Run plot function to create plot of Global_active_power against time
plot(power$dateAndTime, power$Global_active_power, type = "l", main = "", xlab = "", ylab = "")

#Define title for plot
title(ylab = "Global Active Power (kilowatts)")

#Close plot output file
dev.off()