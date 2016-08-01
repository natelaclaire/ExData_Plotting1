# Create a directory to store the data in 
if (!file.exists("data")) {
    dir.create("data")
}

# Download and unzip the data if it isn't already in the data folder
if (!file.exists("data/household_power_consumption")) {
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "data/household_power_consumption.zip")
    unzip("data/household_power_consumption.zip", exdir = "data/household_power_consumption")
}

# Read the data
data_all <- read.csv("data/household_power_consumption/household_power_consumption.txt", 
                 header = TRUE, sep = ";", na.strings = "?", check.names = FALSE, 
                 stringsAsFactors = FALSE)

# Convert the Date column to date format
data_all$Date <- as.Date(data_all$Date, format = "%d/%m/%Y")

# Subset the data, "We will only be using data from the dates 2007-02-01 and 2007-02-02"
data <- subset(data_all, subset = (Date >= "2007-02-01" & Date <= "2007-02-02"))

# Free the memory from the original data set
rm(data_all)

# Create DateTime column to enable time-based charting
data$DateTime <- as.POSIXct(paste(as.Date(data$Date), data$Time))

# Open PNG device
png("plot2.png", 480, 480)

# Generate Plot 2
plot(data$Global_active_power ~ data$DateTime, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")

# Close PNG device
dev.off()