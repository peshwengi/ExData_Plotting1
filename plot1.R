#Read in the raw data, using appropriate char for NA, separator, etc.
power = read.table("household_power_consumption.txt", sep = ";", na.strings="?", header=TRUE)
#Convert the date column to the Date format
power$Date <- as.Date(power$Date, "%d/%m/%Y")
#Subset taking just the data for the two days in question
power = subset( power, Date == as.Date( "2007-02-01" ) 
            | Date == as.Date("2007-02-02" ))
#Open the png device
png(filename = "plot1.png")
#Plot Global active power (using defaults except for colour and labels)
with( power, hist(Global_active_power, col="red", xlab="Global Active Power (kilowatts)", main="Global Active Power"))
#Close the device to write the plot to disk
dev.off()
