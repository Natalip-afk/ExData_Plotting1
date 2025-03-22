# Project 1: Exploratory Data Analysis_plot 2

# 1. Download and unzip the file
url <- "https://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip"
temp <- tempfile()  # Create a temporary file
download.file(url, temp)  # Download the zip file
unzip(temp, files = "household_power_consumption.txt")  # Extract the text file

# 2. Load the data
library(data.table)
file_path <- "household_power_consumption.txt"
data <- fread(file_path, sep = ";", na.strings = "?")  # Read the data handling missing values

# 3. Filter the data for the specified dates (2007-02-01 and 2007-02-02)
filtered_data <- data[Date %in% c("1/2/2007", "2/2/2007")]

# 4. Verify and combine the Date and Time columns into Datetime
datetime_strings <- paste(filtered_data$Date, filtered_data$Time)  # Combine the columns
filtered_data$Datetime <- as.POSIXct(datetime_strings, format = "%d/%m/%Y %H:%M:%S")  # Convert to POSIXct

# 5. Clean the data: remove rows with missing values in Datetime or Global_active_power
filtered_data <- filtered_data[!is.na(filtered_data$Datetime) & !is.na(filtered_data$Global_active_power), ]

# 6. Validate that Datetime and Global_active_power are correctly created
print(summary(filtered_data$Datetime))  # Review the summary of Datetime
print(range(filtered_data$Datetime))  # Range of dates
print(summary(filtered_data$Global_active_power))  # Check power values

# 7. Create the PNG file and plot
png("plot2.png", width = 480, height = 480)

# Create the line plot without x-axis labels
plot(filtered_data$Datetime, filtered_data$Global_active_power, 
     type = "l",  # Line plot
     xlab = "",  # No x-axis labels
     ylab = "Global Active Power (kilowatts)",  # Y-axis label
     main = "",  # No title
     xaxt = "n")  # Suppress default x-axis labels

# 8. Define custom labels for the x-axis
days <- c("Thu", "Fri", "Sat")  # Labels for the days
positions <- c(min(filtered_data$Datetime), 
               min(filtered_data$Datetime) + 86400,  # Add 1 day in seconds
               min(filtered_data$Datetime) + 2 * 86400)  # Add 2 days in seconds

# Add custom labels
axis(1, at = positions, labels = days)

# Save and close the file
dev.off()

