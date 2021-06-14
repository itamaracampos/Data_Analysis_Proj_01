library("data.table")

##setwd("C:/Users/itamara campos/Documentos/Cousera/Data Science Foundations using R Specialization/04_Exploratory Data Analysis/01_week/Assigment")

#Unzip the folder
unzip("exdata_data_household_power_consumption.zip")

#Reads all the dataset
power_all <- read.table("household_power_consumption.txt",skip=1,sep=";")

#Correcting the names according to the "UCI web site":
names(power_all) <- c("Date","Time","Global_active_power","Global_reactive_power",
                      "Voltage","Global_intensity","Sub_metering_1",
                      "Sub_metering_2","Sub_metering_3")

# Filter Dates for 2007-02-01 and 2007-02-02 
power_selected <- subset(power_all,power_all$Date=="1/2/2007"| power_all$Date =="2/2/2007")

###  modification in the format of the data to generate plot 2 

# changing Date & Time vars from characters --> Date and POSIXlt respectively
power_selected$Date     <-       as.Date(power_selected$Date, format="%d/%m/%Y")
power_selected$Time     <-       strptime(power_selected$Time, format="%H:%M:%S")
power_selected[1:1440,"Time"]    <- format(power_selected[1:1440,"Time"],"2007-02-01 %H:%M:%S")
power_selected[1441:2880,"Time"] <- format(power_selected[1441:2880,"Time"],"2007-02-02 %H:%M:%S")


dev.cur()

png("Figure_04.png", width=480, height=480)

par(mfrow=c(2,2))

with(power_selected,{ ## garfica by (row, column)
  # graphic(1,1) 
  plot(power_selected$Time,as.numeric(as.character(power_selected$Global_active_power)),
       type="l",  xlab="",ylab="Global Active Power")  
  
  # graphic(1,2) 
  plot(power_selected$Time,as.numeric(as.character(power_selected$Voltage)), 
       type="l",xlab="datetime",ylab="Voltage")
  
  # graphic(2,1) 
  plot(power_selected$Time,power_selected$Sub_metering_1,type="n",
       xlab="",ylab="Energy sub metering")
       with(power_selected,lines(Time,as.numeric(as.character(Sub_metering_1))))
  with(power_selected,lines(Time,as.numeric(as.character(Sub_metering_2)),col="red"))
  with(power_selected,lines(Time,as.numeric(as.character(Sub_metering_3)),col="blue"))
         legend("topright", lty=1, col=c("black","red","blue"),
         legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), bty="n", cex = 1)
  
  # graphic(2,2) 
  plot(power_selected$Time,as.numeric(as.character(power_selected$Global_reactive_power)),
       type="l",xlab="datetime",ylab="Global_reactive_power")
})

dev.off()