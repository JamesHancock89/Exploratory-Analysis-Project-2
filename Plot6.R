# Load ggplot2 library 
library(ggplot2) 

#load data files
NEI <- readRDS("~/data/summarySCC_PM25.rds") 
SCC <- readRDS("~/data/Source_Classification_Code.rds") 

# Compare emissions from motor vehicle sources in Baltimore City with emissions from motor  
# vehicle sources in Los Angeles County, California (fips == "06037").  

# Search for ON-ROAD type in NEI 
subsetNEI <- NEI[(NEI$fips=="24510"|NEI$fips=="06037") & NEI$type=="ON-ROAD",  ] 

#Aggregate by year and fips for both cities
aggregatedTotalByYearAndFips <- aggregate(Emissions ~ year + fips, subsetNEI, sum) 
aggregatedTotalByYearAndFips$fips[aggregatedTotalByYearAndFips$fips=="24510"] <- "Baltimore, MD" 
aggregatedTotalByYearAndFips$fips[aggregatedTotalByYearAndFips$fips=="06037"] <- "Los Angeles, CA" 

# Create the chart in the same directory as the source code
png('~/data/plot6.png', width=1040, height=480)

ggplot(aggregatedTotalByYearAndFips, aes(factor(year), Emissions)) + facet_grid(. ~ fips) + geom_bar(stat="identity")  + xlab("year") + ylab(expression('Total PM'[2.5]*" Emissions")) + ggtitle('Total Emissions from motor vehicle (type=ON-ROAD) in Baltimore City, MD (fips = "24510") vs Los Angeles, CA (fips = "06037")  1999-2008'

dev.off()

                                                                                                                                                                                                 

