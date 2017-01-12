# Read the emission data & source classification code
if (!"NEI" %in% ls()){
  NEI <- readRDS("summarySCC_PM25.rds")
}
if (!"SCC" %in% ls()){
  SCC <- readRDS("Source_Classification_Code.rds")
}

baltimore <- subset(NEI, fips == '24510')
totalEmission <- tapply(baltimore$Emissions, baltimore$year, sum, na.rm=TRUE)
year <- as.Date(as.character(unique(baltimore$year)), '%Y')

png(filename = 'plot2.png', width = 480, height = 480, units = 'px')
plot(year, totalEmission, type="l", pch=20, cex=2, col='blue', xlab = 'Year',
     ylab = 'Total PM 2.5 Emission (ton)', main = 'Baltimore City')
dev.off()