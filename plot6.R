##6.Compare emissions from motor vehicle sources in Baltimore City with emissions 
##from motor vehicle sources in Los Angeles County, California (fips=="06037").
##Which city has seen greater changes over time in motor vehicle emissions?

library(ggplot2)

##Download and Unziped the file 
url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
datafile1<-"datafile1.zip"
if(!file.exists(datafile1)){download.file(url, destfile=datafile1, method="auto"); unzip(datafile1, exdir=".")}

##Reading the dataset
NEI <-readRDS("summarySCC_PM25.rds")
SCC<-readRDS("Source_Classification_Code.rds")

##Finding subset of NEI for Baltimore City (Maryland, fips="24510") and Los Angeles County (California, fips=="06037")
motorVehicle<- subset(NEI,NEI$fips=="24510"| NEI$fips=="06037" & NEI$type=="ON-ROAD")

## Finding the Total emission of Baltimore City and LOs Angeles country per year and Fips
total_Motorvehicle <- aggregate(motorVehicle$Emissions,by=list(motorVehicle$fips, motorVehicle$year),
                                     FUN=sum)
colnames(total_Motorvehicle)<- c("City","year","Emission")

## creating a plot compairing motor vehicles from Baltimore City and Los Angeles Country

png(filename="plot6.png")

vehicle<- ggplot(data=total_Motorvehicle, aes(year,Emission, col=City))
vehicle<- vehicle + geom_point(size=4, alpha= 1/2)+
  labs(x="year")+ labs(y="Total PM2.5 Emission per from motor vehicle") +
  labs(title="compairison of Emission by Motor Vehicles In Baltimore and LosAngeles")

vehicle           
dev.off()

