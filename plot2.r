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

png(file="plot2.png")
plot(datetime, data$Global_active_power,
     type="l",
     xlab="",
     ylab="Global Active Power (kilowatts)",
     col="black"
)
dev.off()
