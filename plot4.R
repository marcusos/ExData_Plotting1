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

plot4 <- function(df) {
  par(mfrow = c(2, 2), mar = c(4,4,1,1))
  
  with(df, {
    plot(df$Date, df$Global_active_power, xlab = '', 
         ylab = 'Global Active Power', type = 'l')
    plot(df$Date, df$Voltage, xlab = 'datetime', 
         ylab = 'Voltage', type = 'l')
    
    plot(df$Date, df$Sub_metering_1,  col='black', xlab = '',
         ylab = 'Energy sub metering', type = 'l')
    lines(df$Date, df$Sub_metering_2, col='red')
    lines(df$Date, df$Sub_metering_3, col='blue')
    legend("topright", col = c("black", "blue", "red"), lty = c(1, 1, 1), bty='n', cex=0.8,
           legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    
    plot(df$Date, df$Global_reactive_power, ylab = 'Global_reactive_power',
         xlab = 'datetime', type = 'l')
    
  })
  
  dev.copy(png, file = "plot4.png") ## Copy my plot to a PNG file
  dev.off() 
  
}

df <- readData()
plot4(df)






