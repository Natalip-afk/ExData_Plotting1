# Project 1 Exploratory Data Analysis_plot_sub_metering.png

# 1. Download and unzip the file
url <- "https://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip"
temp <- tempfile()  # Create a temporary file
download.file(url, temp)  # Download the zip file
unzip(temp, files = "household_power_consumption.txt")  # Extract the text file

# 2. Load the data
library(data.table)
file_path <- "household_power_consumption.txt"
data <- fread(file_path, sep = ";", na.strings = "?")  # Read the data handling missing values

# 3. Filter the data by specified dates (2007-02-01 and 2007-02-02)
filtered_data <- data[Date %in% c("1/2/2007", "2/2/2007")]

# 4. Verify and combine the Date and Time columns into Datetime
datetime_strings <- paste(filtered_data$Date, filtered_data$Time)  # Combine the columns
filtered_data$Datetime <- as.POSIXct(datetime_strings, format = "%d/%m/%Y %H:%M:%S")  # Convert to POSIXct

# 5. Clean the data: remove rows with missing values in Datetime or Global_active_power
filtered_data <- filtered_data[!is.na(filtered_data$Datetime) & !is.na(filtered_data$Global_active_power), ]

# 6. Validate that Datetime and Global_active_power are correctly created
print(summary(filtered_data$Datetime))  # Check the summary of Datetime
print(range(filtered_data$Datetime))  # Date range
print(summary(filtered_data$Global_active_power))  # Check power values

# Create the PNG file to save the plots
png("plot4.png", width = 800, height = 800)

# Divide the plotting area into a 2x2 grid
par(mfrow = c(2, 2))

# 1. Plot of Global_active_power
plot(filtered_data$Datetime, filtered_data$Global_active_power, type = "l", col = "black",
     xlab = "", ylab = "Global Active Power", 
     main = "Global Active Power")

# 2. Plot of Voltage
plot(filtered_data$Datetime, filtered_data$Voltage, type = "l", col = "black",
     xlab = "Datetime", ylab = "Voltage", 
     main = "Voltage")

# 3. Plot of Sub_metering_1, Sub_metering_2, and Sub_metering_3
plot(filtered_data$Datetime, filtered_data$Sub_metering_1, type = "l", col = "black",
     xlab = "", ylab = "Energy Sub Metering",
     main = "Sub Metering")
lines(filtered_data$Datetime, filtered_data$Sub_metering_2, col = "red")
lines(filtered_data$Datetime, filtered_data$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"), lty = 1, cex = 0.8)

# 4. Plot of Global_reactive_power
plot(filtered_data$Datetime, filtered_data$Global_reactive_power, type = "l", col = "black",
     xlab = "Datetime", ylab = "Global Reactive Power", 
     main = "Global Reactive Power")

# Save the file and close
dev.off()
