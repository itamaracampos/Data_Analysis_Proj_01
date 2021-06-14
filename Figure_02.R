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

png("Figure_02.png", width=480, height=480)


# PLOT
plot(power_selected$Time, as.numeric( as.character(power_selected$Global_active_power))
     ,type="l",xlab="",ylab="Global Active Power (kilowatts)") 

# TITLE
title(main="Global Active Power Vs Time")

dev.off()