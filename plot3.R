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

plot3 <- function(df) {
  par(mfrow = c(1, 1))
  
  plot(df$Date, df$Sub_metering_1,  col='black', xlab = '',
       ylab = 'Energy sub metering', type = 'l')
  
  lines(df$Date, df$Sub_metering_2, col='red')
  lines(df$Date, df$Sub_metering_3, col='blue')
  
  legend("topright", col = c("black", "blue", "red"), lty = c(1, 1, 1), cex=1.2,
         legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  
  dev.copy(png, file = "plot3.png") ## Copy my plot to a PNG file
  dev.off() 
}

df <- readData()
plot3(df)









