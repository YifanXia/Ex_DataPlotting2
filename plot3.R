library(ggplot2)

# Read the emission data & source classification code
if (!"NEI" %in% ls()){
  NEI <- readRDS("summarySCC_PM25.rds")
}
if (!"SCC" %in% ls()){
  SCC <- readRDS("Source_Classification_Code.rds")
}

baltimore <- subset(NEI, fips == '24510')
aggregated <- aggregate(baltimore$Emissions, 
                        list('type' = baltimore$type, 'year'= baltimore$year),
                        FUN = sum, na.rm=TRUE)

png(filename = 'plot3.png', width = 480, height = 480, units = 'px')
par("mar"=c(5.1, 4.5, 4.1, 2.1))
g <- ggplot(aggregated, aes(year, x))
g + geom_line(aes(col=type)) +
  labs(title = "PM 2.5 emission per source type in Baltimore City")) +
  labs(x = "Year", y = "PM 2.5 emission"))
dev.off()
