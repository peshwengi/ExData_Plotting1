#Read in the raw data, using appropriate char for NA, separator, etc.
power = read.table("household_power_consumption.txt", sep = ";", na.strings="?", header=TRUE)
#Convert the date column to the Date format
power$Date <- as.Date(power$Date, "%d/%m/%Y")
#Subset taking just the data for the two days in question
power = subset( power, Date == as.Date( "2007-02-01" ) 
                | Date == as.Date("2007-02-02" ))
#Create a dateTime column which contains a time and date value
#as.POSIXct automatically uses strptime() if you pass in character paramaters 
#so no need to call that explicitly
power$dateTime <- as.POSIXct(paste(power$Date, power$Time), format="%F %T")
#Open the png device
png(filename = "plot2.png")
#Plot Global active power (using defaults except for colour and labels)
with( power, plot(dateTime, Global_active_power, type="l", 
                  xlab="", ylab="Global Active Power (kilowatts)"))
#Close the device to write the plot to disk
dev.off()