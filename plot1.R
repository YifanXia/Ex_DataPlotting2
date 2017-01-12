# Read the emission data & source classification code
if (!"NEI" %in% ls()){
  NEI <- readRDS("summarySCC_PM25.rds")
}
if (!"SCC" %in% ls()){
  SCC <- readRDS("Source_Classification_Code.rds")
}

totalEmission <- tapply(NEI$Emissions, NEI$year, sum, na.rm=TRUE)
year <- as.Date(as.character(unique(NEI$year)), '%Y')

png(filename = 'plot1.png', width = 480, height = 480, units = 'px')
plot(year, totalEmission, type = "l", pch=20, cex=2, col='blue', xlab = 'Year',
     ylab = 'Total PM 2.5 Emission (ton)', main = 'U.S.')
dev.off()