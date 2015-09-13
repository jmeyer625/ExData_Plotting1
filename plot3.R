#Download and unzip file
file <- download.file('https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip', './data.zip', method='curl')
unzip('./data.zip')

#Load and transform data to appropriate types
dat <- read.table('household_power_consumption.txt', header=TRUE, sep=';')
dat = subset(dat, dat$Date == '1/2/2007' | dat$Date == '2/2/2007')
dat$Date <- as.Date(dat$Date, format='%d/%m/%Y')
dat$datetime <- strptime(paste(dat$Date, dat$Time), "%Y-%m-%d %H:%M:%S")

#Plot data
plot(dat$datetime, dat$Sub_metering_1, type='l', xlab="", ylab="Energy sub metering")
lines(dat$datetime, dat$Sub_metering_2, col="red1")
lines(dat$datetime, dat$Sub_metering_3, col="blue1")
legend(x="topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=c(1,1), col=c("black", "red1", "blue1"), cex=0.5)

#Copy to png
dev.copy(png, file="plot3.png")

#Close screen device
dev.off()
