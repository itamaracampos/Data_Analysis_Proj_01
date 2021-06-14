

library("data.table")

##setwd("C:/Users/itamara campos/Documentos/Cousera/Data Science Foundations using R Specialization/04_Exploratory Data Analysis/01_week/Assigment")

#Unzip the folder
unzip("exdata_data_household_power_consumption.zip")

#Reads all the dataset
power_all <- data.table::fread(input = "household_power_consumption.txt" , na.strings="?")

# changing format of the variables to numeric
power_all[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

# Change Date Column to Date Type
power_all[, Date := lapply(.SD, as.Date, "%d/%m/%Y"), .SDcols = c("Date")]

# Filter Dates for 2007-02-01 and 2007-02-02
power_selected <- power_all[(Date >= "2007-02-01") & (Date <= "2007-02-02")]

dev.cur()

png("Figure_02.png", width=480, height=480)

## Plot 1
hist(power_selected[, Global_active_power], main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

dev.off()