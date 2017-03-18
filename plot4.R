library(dplyr)
library(reshape2)

#Read in power data from text file
power <- read.table("household_power_consumption.txt", header = TRUE, na.strings = "?", sep = ";", stringsAsFactors = FALSE)

#Assign filename for .png output
png(filename = "plot4.png")
par(mfcol = c(2, 2))

#Create date variable
power$dateOnly <- as.Date(power$Date, format = "%d/%m/%Y")

#Filter data for 1st two days of February 2007
power <- filter(power, (dateOnly == as.Date("2007-02-01") | dateOnly == as.Date("2007-02-02")) & !is.na(power$Global_active_power))

#Create date/time variable from Date and Time variables in power
power$dateAndTime <- as.POSIXct(paste(power$Date, power$Time), format = "%d/%m/%Y %H:%M:%S")

#Run plot function to create plot of Global_active_power against time
plot(power$dateAndTime, power$Global_active_power, type = "l", main = "", xlab = "", ylab = "")

#Define title for plot
title(ylab = "Global Active Power")

#Re-structure data so that there is one row per sub metering measure
powerMelt <- melt(power, measure.vars = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#Create template for plot
with(powerMelt, plot(dateAndTime, value, main = "", xlab = "", ylab = "", type = "n"))

#Subset data for Sub_metering_1 to make colour of line black
with(subset(powerMelt, variable == "Sub_metering_1"), lines(dateAndTime, value, col = "black"))

#Subset data for Sub_metering_1 to make colour of line red
with(subset(powerMelt, variable == "Sub_metering_2"), lines(dateAndTime, value, col = "red"))

#Subset data for Sub_metering_1 to make colour of line blue
with(subset(powerMelt, variable == "Sub_metering_3"), lines(dateAndTime, value, col = "blue"))

#Create legend for plot
legend("topright", lwd = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#Define title for plot
title(ylab = "Energy sub metering")

#Run plot function to create plot of Voltage against time
plot(power$dateAndTime, power$Voltage, type = "l", main = "", xlab = "", ylab = "")

#Define title for plot
title(xlab = "datetime", ylab = "Voltage")

#Run plot function to create plot of Global_reactive_power against time
plot(power$dateAndTime, power$Global_reactive_power, type = "l", main = "", xlab = "", ylab = "")

#Define title for plot
title(xlab = "datetime", ylab = "Global_reactive_power")

#Close plot output file
dev.off()
