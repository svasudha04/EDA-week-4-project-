##1.Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system, 
##make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.

##Download and Unziped the file 
url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
datafile1<-"datafile1.zip"
if(!file.exists(datafile1)){download.file(url, destfile=datafile1, method="auto"); unzip(datafile1, exdir=".")}

##Reading the dataset
NEI <-readRDS("summarySCC_PM25.rds")
SCC<-readRDS("Source_Classification_Code.rds")

# Finding the Total emission per year
total_emission <- aggregate(NEI$Emissions,by=list(year=NEI$year), FUN=sum)
  
##Creating a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.

png(filename="plot1.png")
barplot(names.arg=total_emission$year, height=total_emission$x, 
                               xlab="year", ylab="Total PM2.5 Emission per year", col="red",
                             main="Total PM2.5 Emission per Year of United States")
dev.off()