#Read in the raw data, using appropriate char for NA, separator, etc.
power = read.table( "household_power_consumption.txt", sep = ";", na.strings="?", header=TRUE )
#Convert the date column to the Date format
power$Date <- as.Date( power$Date, "%d/%m/%Y" )
#Subset taking just the data for the two days in question
power = subset( power, Date == as.Date( "2007-02-01" ) 
                | Date == as.Date( "2007-02-02" ))
#Create a dateTime column which contains a time and date value
#as.POSIXct automatically uses strptime() if you pass in character paramaters 
#so no need to call that explicitly
power$dateTime <- as.POSIXct( paste( power$Date, power$Time ), format="%F %T" )
#Open the png device
png(filename = "plot3.png")
#Plot Global active power (using defaults except for colour and labels)
with( power, plot( dateTime, Sub_metering_1, type="l", 
                  xlab="", ylab="Energy sub metering" ))
with( power, points( dateTime, Sub_metering_2, type="l", col="red" ))
with( power, points( dateTime, Sub_metering_3, type="l", col="blue" ))
legend( "topright", col=c( "black", "red", "blue" ), lty=1,
    legend = c( "Sub_metering_1", "Sub_metering_2", "Sub_metering_3" ))
#Close the device to write the plot to disk
dev.off()