library(ggplot2)
## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Across the United States, how have emissions from coal 
#combustion-related sources changed from 1999–2008?

#Find lines with coal in Short.Names in SCC
#ignore.case = ignore alphabetical variations
A = grep("coal",SCC$Short.Name,ignore.case=TRUE)

# Sort SCC data based on rows identified in vector A
coal_SCC <- SCC[A,]

#Merge coal_SCC and NEI based on SCC values. Sort them by year.
coal_NEI <- merge(NEI,coal_SCC,by.x ="SCC", by.y="SCC")
byyear <- aggregate(Emissions ~ year,coal_NEI,sum)

#Plot
#factor(year) to make sure x-axis is in actual year nos.
#stat + identity to make sure geom_bar takes y=emission
png("plot4.png")
g <- ggplot(byyear,aes(factor(year),Emissions))
g <- g + geom_bar(stat="identity") + 
        xlab ("Year") + 
        ylab ("PM 2.5 Emissions (Tons)") +
        ggtitle ("Total Emissions from Coal Sources")
print(g)
dev.off()