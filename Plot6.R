library(ggplot2)
library(gridExtra)
## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Compare emissions from motor vehicle sources in Baltimore City with 
#emissions from motor vehicle sources in Los Angeles County, 
#California (fips == "06037"). Which city has seen greater changes 
#over time in motor vehicle emissions?

#Filter by Location & Type
Motors_Balt <- NEI[NEI$type == "ON-ROAD" & NEI$fips==24510,]
fips_LA = grep(06037, NEI$fips)
Motors_LA <- NEI[fips_LA,]
type_LA <- grep("ON-ROAD",Motors_LA$type)
Motors_LA <- Motors_LA [type_LA,]

#Aggregate 
byyear_Balt <- aggregate(Emissions ~ year,Motors_Balt,sum)
byyear_LA <- aggregate(Emissions ~ year,Motors_LA,sum)

#Plot
png("plot6.png",width = 1040,height=480)
g <- ggplot(byyear_Balt,aes(factor(year),Emissions))
g <- g + geom_bar(stat="identity") + 
        xlab ("Year") + 
        ylab ("PM 2.5 Emissions (Tons)") +
        ggtitle("Total Emission in Baltimore")


f <- ggplot(byyear_LA,aes(factor(year),Emissions))
f <- f + geom_bar(stat="identity") + 
        xlab ("Year") + 
        ylab ("PM 2.5 Emissions (Tons)") +
        ggtitle("Total Emission in LA")

#grid.arrange allows easy arrangeemnt of plots.
plot <- grid.arrange(g,f,nrow=1)
print(plot)
dev.off()