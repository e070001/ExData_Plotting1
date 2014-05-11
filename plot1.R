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

png("plot1.png", width = 480, height = 480)
hist(as.numeric(data_subset$Global_active_power), col="red", 
     main = "Global Active Power",xlab="Global Active Power (kilowatts)")
dev.off()
