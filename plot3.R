##3. Of the four types of sources indicated by type (point, nonpoint, onroad, nonroad) variable, 
##which of these four sources have seen decreases in emissions from 1999-2008 for Baltimore City? 
##Which have seen increases in emissions from 1999-2008? 
##Use the ggplot2 plotting system to make a plot answer this question.

library(ggplot2)

##Download and Unziped the file 
url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
datafile1<-"datafile1.zip"
if(!file.exists(datafile1)){download.file(url, destfile=datafile1, method="auto"); unzip(datafile1, exdir=".")}

##Reading the dataset
NEI <-readRDS("summarySCC_PM25.rds")
SCC<-readRDS("Source_Classification_Code.rds")

##Finding subset of NEI for Baltimore City (Maryland, fips="24510")
baltimore<- subset(NEI,NEI$fips=="24510")

## Finding the Total emission of Baltimore City per year and Type
baltimore_total_emission <- aggregate(baltimore$Emissions,by=list(baltimore$type, baltimore$year),
                                      FUN=sum)
colnames(baltimore_total_emission)<- c("type","year","Emission")

##Creating a plot using ggplot graphics showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.

png(filename="plot3.png")

emission_type<- ggplot(data=baltimore_total_emission, aes(year,Emission))
emission_type<- emission_type + geom_point(color="blue", size=4, alpha= 1/2)+
               facet_grid(.~type) + labs(x="year")+ labs(y="Total PM2.5 Emission per year") +
               labs(title="Total PM2.5 Emission in Baltimore from 1999 to 2008")
  
emission_type              
dev.off()
