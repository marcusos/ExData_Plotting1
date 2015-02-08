library(RSQLite)
library(lubridate)

Sys.setlocale("LC_TIME", "C")

readData <- function() {

  #reading csv file
  df <- read.csv(file="household_power_consumption.txt", sep = ';', nrows = 69520)
  
  #subsetting the data
  df <- subset(df, Date == '1/2/2007' | Date == '2/2/2007')
  
  #converting str to date
  df$Date <- strptime(paste(df$Date, df$Time) , "%d/%m/%Y %H:%M:%S"); 
  #df$Date <- strptime(df$Date, "")
  #df$day <- wday(df$Date, label=TRUE, abbr = TRUE)
  
  #converting to number
  #df$Global_active_power <- as.numeric(df$Global_active_power)
  df$Global_active_power <- as.numeric(as.character(df$Global_active_power))
  
  df$Sub_metering_1 <- as.numeric(as.character(df$Sub_metering_1))
  df$Sub_metering_2 <- as.numeric(as.character(df$Sub_metering_2))
  df$Sub_metering_3 <- as.numeric(as.character(df$Sub_metering_3))
  
  df$Voltage <- as.numeric(as.character(df$Voltage))
  
  df$Global_reactive_power <- as.numeric(as.character(df$Global_reactive_power))
  
  df
}

plot1 <- function(df) {
  par(mfrow = c(1, 1))
  
  hist(df$Global_active_power, col="red", 
          xlab = 'Global Active Power (kilowatts)', ylab= 'Frequency', main = "Global Active Power")
  
  dev.copy(png, file = "plot1.png") ## Copy my plot to a PNG file
  dev.off() 
}

df <- readData()
plot1(df)





