##2.Have total emissions from PM2.5 decreased in the Baltimore City,
##Maryland (fips == "24510") from 1999 to 2008? 
##Use the base plotting system to make a plot answering this question.

##Download and Unziped the file 
url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
datafile1<-"datafile1.zip"
if(!file.exists(datafile1)){download.file(url, destfile=datafile1, method="auto"); unzip(datafile1, exdir=".")}

##Reading the dataset
NEI <-readRDS("summarySCC_PM25.rds")
SCC<-readRDS("Source_Classification_Code.rds")

##Finding subset of NEI for Baltimore City (Marylanf, fips="24510")
baltimore<- subset(NEI,NEI$fips=="24510")
## Finding the Total emission per year
baltimore_total_emission <- aggregate(baltimore$Emissions,by=list(year=baltimore$year), FUN=sum)

##Creating a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.

png(filename="plot2.png")
barplot(names.arg=baltimore_total_emission$year, height=baltimore_total_emission$x, 
        xlab="year", ylab="Total PM2.5 Emission per year", col="wheat",
        main="Total PM2.5 Emission of Baltimore City from 1999 to 2008")
dev.off()