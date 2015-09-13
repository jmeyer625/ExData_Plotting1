#Download and unzip file
file <- download.file('https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip', './data.zip', method='curl')
unzip('./data.zip')

#Load and transform data to appropriate types
dat <- read.table('household_power_consumption.txt', header=TRUE, sep=';')
dat = subset(dat, dat$Date == '1/2/2007' | dat$Date == '2/2/2007')
dat$Date <- as.Date(dat$Date, format='%d/%m/%Y')
dat$datetime <- strptime(paste(dat$Date, dat$Time), "%Y-%m-%d %H:%M:%S")
dat$Global_active_power <- as.numeric(levels(dat$Global_active_power)[dat$Global_active_power])

#Plot data
plot(dat$datetime, dat$Global_active_power, type="l", xlab="", ylab = "Global Active Power (kilowatts)")

#Copy to png
dev.copy(png, file="plot2.png")

#Close screen device
dev.off()