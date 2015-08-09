## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Filter by Location
Baltimore <- NEI[NEI$fips==24510,]

# Aggregate by year
byyear <- aggregate(Baltimore$Emissions,list(Baltimore$year),sum)

#Plot
png("plot2.png")
barplot(byyear$x,names.arg=byyear$Group.1,
        main="Total PM 2.5 Emission by Year in Baltimore",
        xlab="Year",  ylab="PM 2.5 Emissions (tons)")
dev.off()