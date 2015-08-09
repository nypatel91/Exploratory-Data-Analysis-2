library(ggplot2)
## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")



# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
# which of these four sources have seen decreases in emissions from 1999 2008 for Baltimore City? 
# Which have seen increases in emissions from 1999 2008? 
# Use the ggplot2 plotting system to make a plot answer this question.

#Filter by Location
Baltimore <- NEI[NEI$fips==24510,]

#Aggregate 
bycrit <- aggregate(Emissions ~ year + type,Baltimore,sum)

#Plot
png("plot3.png")
g <- ggplot(bycrit,aes(year,Emissions))
g <- (g + geom_line(aes(color=type)) + 
                     xlab ("Year") + 
                     ylab ("PM 2.5 Emissions (Tons)"))
print(g)
dev.off()