#Download and unzip file
file <- download.file('https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip', './data.zip', method='curl')
unzip('./data.zip')

#Load and transform data to appropriate types
dat <- read.table('household_power_consumption.txt', header=TRUE, sep=';')
dat = subset(dat, dat$Date == '1/2/2007' | dat$Date == '2/2/2007')
dat$Date <- as.Date(dat$Date, format='%d/%m/%Y')
dat$datetime <- strptime(paste(dat$Date, dat$Time), "%Y-%m-%d %H:%M:%S")
dat$Global_active_power <- as.numeric(levels(dat$Global_active_power)[dat$Global_active_power])
dat$Global_reactive_power <- as.numeric(levels(dat$Global_reactive_power)[dat$Global_reactive_power])
dat$Voltage <- as.numeric(levels(dat$Voltage)[dat$Voltage])

#Plot data
par(mfrow=c(2,2))
plot(dat$datetime, dat$Global_active_power, type="l", xlab="", ylab = "Global Active Power (kilowatts)")
plot(dat$datetime, dat$Voltage, type="l", xlab = "datetime", ylab="Voltage")
plot(dat$datetime, dat$Sub_metering_1, type='l', xlab="", ylab="Energy sub metering")
lines(dat$datetime, dat$Sub_metering_2, col="red1")
lines(dat$datetime, dat$Sub_metering_3, col="blue1")
legend(x="topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=c(1,1), col=c("black", "red1", "blue1"), cex=0.5)
plot(dat$datetime, dat$Global_reactive_power, type="l", xlab = "datetime", ylab="Global_reactive_power")

#Copy to png
dev.copy(png, file="plot4.png")

#Close screen device
dev.off()