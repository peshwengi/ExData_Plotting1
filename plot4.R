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
power$datetime <- as.POSIXct( paste( power$Date, power$Time ), format="%F %T" )
#Open the png device
png(filename = "plot4.png")
par(mfrow = c( 2,2 ))
with( power, {
    plot( datetime, Global_active_power, type="l", 
                  xlab="", ylab="Global Active Power")
    plot( datetime, Voltage, type="l" )
    plot( datetime, Sub_metering_1, type="l", 
                       xlab="", ylab="Energy sub metering" )
    points( datetime, Sub_metering_2, type="l",col="red" )
    points( datetime, Sub_metering_3, type="l", col="blue" )
    legend( "topright", col=c( "black", "red", "blue" ), lty=1,
            legend = c( "Sub_metering_1", "Sub_metering_2", "Sub_metering_3" ))
    plot( datetime, Global_reactive_power, type="l" )
})
dev.off()