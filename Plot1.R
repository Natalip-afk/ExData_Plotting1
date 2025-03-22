# Project 1 Exploratory Data Analysis_Plot1

# Download and unzip the compressed file
url <- "https://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip"
temp <- tempfile()  # Create a temporary file
download.file(url, temp)  # Download the zip file
unzip(temp, files = "household_power_consumption.txt")  # Extract the text file

# Load the data
library(data.table)
file_path <- "household_power_consumption.txt"
data <- fread(file_path, sep = ";", na.strings = "?")  # Read data while handling missing values

# Filter the data for the specified dates (2007-02-01 and 2007-02-02)
filtered_data <- data[Date %in% c("1/2/2007", "2/2/2007")]

# Create a DateTime column by combining Date and Time
filtered_data$DateTime <- as.POSIXct(paste(filtered_data$Date, filtered_data$Time), 
                                     format = "%d/%m/%Y %H:%M:%S")

# Verify the range of filtered dates (optional)
range(filtered_data$DateTime)

library(data.table)

# Read the data
file_path <- "household_power_consumption.txt"
data <- fread(file_path, sep = ";", na.strings = "?")

# Filter the data for specific dates (2007-02-01 and 2007-02-02)
filtered_data <- data[Date %in% c("1/2/2007", "2/2/2007")]

# Create the DateTime column
filtered_data$DateTime <- as.POSIXct(paste(filtered_data$Date, filtered_data$Time), 
                                     format = "%d/%m/%Y %H:%M:%S")
write.csv(filtered_data, "filtered_data.csv", row.names = FALSE)

# Plot1.R: Plot 1
filtered_data <- read.csv("filtered_data.csv")

# Create the PNG file
png("plot1.png", width = 480, height = 480)

# Build the plot
hist(filtered_data$Global_active_power, main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)", col = "red")

dev.off()  # Save the file