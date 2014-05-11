filename <- "./household_power_consumption.txt"
data_raw <- read.table(filename,
                       sep=";",
                       header=TRUE,
                       stringsAsFactors =FALSE,
                       na.strings = "?",
                       colClasses = c('character', # Date
                                      'character', # Time
                                      'numeric',   # Global_active_power
                                      'numeric',   # Global_reactive_power
                                      'numeric',   # Voltage
                                      'numeric',   # Global_intensity
                                      'numeric',   # Sub_metering_1
                                      'numeric',   # Sub_metering_2
                                      'numeric')   # Sub_metering_3
)

data_raw$DateTime <- strptime(paste(data_raw$Date, data_raw$Time), 
                              "%d/%m/%Y %H:%M:%S")

data_subset <- subset(data_raw, 
                      as.Date(DateTime) >= as.Date("2007-02-01") & 
                        as.Date(DateTime) <= as.Date("2007-02-02"))

png("plot4.png", height=480, width=480)

par(mfrow=c(2,2))

plot(data_subset$DateTime, 
     data_subset$Global_active_power, 
     pch=NA, 
     xlab="", 
     ylab="Global Active Power (kilowatts)")
lines(data_subset$DateTime, data_subset$Global_active_power)

plot(data_subset$DateTime, data_subset$Voltage, ylab="Voltage", xlab="datetime", pch=NA)
lines(data_subset$DateTime, data_subset$Voltage)

plot(data_subset$DateTime, 
     data_subset$Sub_metering_1, 
     pch=NA, 
     xlab="", 
     ylab="Energy sub metering")
lines(data_subset$DateTime, data_subset$Sub_metering_1)
lines(data_subset$DateTime, data_subset$Sub_metering_2, col='red')
lines(data_subset$DateTime, data_subset$Sub_metering_3, col='blue')
legend('topright', 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty = c(1,1,1),
       col = c('black', 'red', 'blue'),
       bty = 'n')

with(data_subset, plot(DateTime, Global_reactive_power, xlab='datetime', pch=NA))
with(data_subset, lines(DateTime, Global_reactive_power))

dev.off()