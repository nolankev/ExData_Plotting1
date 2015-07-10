#####################
## Acquiring the data
#####################


## Assume the data is downloaded and unzipped to working directory
filename <- "household_power_consumption.txt"


## Read only a portion of the file (sep=";")
## Add column header
## Subset to only the two desired dates
data <- read.csv2(filename, header=TRUE, nrows=4000, skip=66000, colClasses="character")
forHeader <- read.csv2("household_power_consumption.txt", header=TRUE, nrows=1)
colnames(data) <- colnames(forHeader)
data <- data[data$Date==c("1/2/2007","2/2/2007"),]


## Combine & convert dates and times to a single variable 'datetime'
## Convert the other columns from character to numeric
datetime <- paste(data$Date, data$Time, sep=" ")
datetime <- strptime(datetime, format="%d/%m/%Y %H:%M:%S")
data[,3:9] <- sapply(data[,3:9], as.numeric)


###################
## Creating the png
###################
png(file="plot4.png")
par(mfrow=c(2,2))

# mini-plot[1,1]
plot(datetime, data$Global_active_power,
     type="l",
     col="black",
     xlab="",
     ylab="Global Active Power"
)

# mini-plot[1,2]
plot(datetime, data$Voltage,
     type="l",
     col="black",
     xlab="datetime",
     ylab="Voltage"
)

# mini-plot[2,1]
plot(datetime, data$Sub_metering_1,
     type="l",
     col="black",
     xlab="",
     ylab="Energy sub metering"
)
points(datetime, data$Sub_metering_2,     
       type = "l",
       col="red"
)
points(datetime, data$Sub_metering_3,
       type = "l",
       col="blue"
)
legend("topright", bty="n", lwd=1, col=c("black", "red", "blue"), legend=colnames(data[7:9]))

# mini-plot[2,2]
with(data,
     plot(datetime, Global_reactive_power,
          type="l",
          col="black"
     )
)
dev.off()