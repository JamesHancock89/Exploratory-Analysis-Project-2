# Load ggplot2 library 
library(ggplot2) 

# Loading provided datasets - loading from local machine 
NEI <- readRDS("~/data/summarySCC_PM25.rds") 
SCC <- readRDS("~/data/Source_Classification_Code.rds") 

# How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City? 
# Search for ON-ROAD type in NEI 

subsetNEI <- NEI[NEI$fips=="24510" & NEI$type=="ON-ROAD",  ] 
aggregatedTotalByYear <- aggregate(Emissions ~ year, subsetNEI, sum) 


# Create the chart in the same directory as the source code 
png('~/data/plot5.png',width=840, height=480)

ggplot(aggregatedTotalByYear, aes(factor(year), Emissions))+ geom_bar(stat="identity") + xlab("year") + ylab(expression('Total PM'[2.5]*" Emissions")) + ggtitle('Total Emissions from motor vehicle (type = ON-ROAD) in Baltimore City, Maryland (fips = "24510") from 1999 to 2008') 

dev.off()


