library(ggplot2)
## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#How have emissions from motor vehicle sources changed from 1999–2008 
#in Baltimore City?

#Filter by Location & Type
Motors <- NEI[NEI$type=="ON-ROAD" & NEI$fips==24510,]

#Aggregate 
byyear <- aggregate(Emissions ~ year,Motors,sum)

#Plot
png("plot5.png")
g <- ggplot(byyear,aes(factor(year),Emissions))
g <- (g + geom_bar(stat="identity") + 
        xlab ("Year") + 
        ylab ("PM 2.5 Emissions (Tons)"))
print(g)
dev.off()