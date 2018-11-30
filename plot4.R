##4.Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?

library(ggplot2)

##Download and Unziped the file 
url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
datafile1<-"datafile1.zip"
if(!file.exists(datafile1)){download.file(url, destfile=datafile1, method="auto"); unzip(datafile1, exdir=".")}

##Reading the dataset
NEI <-readRDS("summarySCC_PM25.rds")
SCC<-readRDS("Source_Classification_Code.rds")

##Finding all records involving coal combustion from source classification code and NEI
coal_SCC<- SCC[grepl("Coal",SCC$Short.Name), ]
coal_NEI<- NEI[NEI$SCC %in% coal_SCC$SCC, ]


## Finding the Total emission of Coal combustion per year
coal_total_emission <- aggregate(coal_NEI$Emissions,by=list(coal_NEI$year), FUN=sum)
colnames(coal_total_emission)<- c("year","Emission")

##Creating a plot using ggplot graphics showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.

png(filename="plot4.png")

coal_comb<- ggplot(data=coal_total_emission, aes(year,Emission))
coal_comb<- coal_comb + geom_point(color="red", size=4, alpha= 1/2)+
            labs(x="year")+ labs(y="Total PM2.5 Emission per year") +
            labs(title="Total Coal Combustion Emission In US")

coal_comb            
dev.off()
