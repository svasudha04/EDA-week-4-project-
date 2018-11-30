##5.How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?

library(ggplot2)

##Download and Unziped the file 
url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
datafile1<-"datafile1.zip"
if(!file.exists(datafile1)){download.file(url, destfile=datafile1, method="auto"); unzip(datafile1, exdir=".")}

##Reading the dataset
NEI <-readRDS("summarySCC_PM25.rds")
SCC<-readRDS("Source_Classification_Code.rds")
##Finding subset of NEI for Baltimore City (Maryland, fips="24510")
baltimore_motorVehicle<- subset(NEI,NEI$fips=="24510" & NEI$type=="ON-ROAD")
## Finding the Total emission of Baltimore City per year and Type
baltimore_total_vehicle <- aggregate(baltimore_motorVehicle$Emissions,by=list(baltimore_motorVehicle$year),
                                      FUN=sum)
colnames(baltimore_total_vehicle)<- c("year","Emission")

##Creating a plot using ggplot graphics showing the total PM2.5 emission from motor Vehicles for each of the years 1999, 2002, 2005, and 2008.

png(filename="plot5.png")

vehicle<- ggplot(data=baltimore_total_vehicle, aes(year,Emission))
vehicle<- vehicle + geom_point(color="red", size=4, alpha= 1/2)+
  labs(x="year")+ labs(y="Total PM2.5 Emission per year") +
  labs(title="Total Emission through Motor Vehicles In Baltimore")

vehicle           
dev.off()
