## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Aggregate by year
byyear <- aggregate(NEI$Emissions,list(NEI$year),sum)

#Plot
png("plot1.png")
barplot(byyear$x,names.arg=byyear$Group.1,
        main="Total PM 2.5 Emission by Year",
        xlab="Year",  ylab="PM 2.5 Emissions (tons)")
dev.off()