# Read the emission data & source classification code
if (!"NEI" %in% ls()){
  NEI <- readRDS("summarySCC_PM25.rds")
}
if (!"SCC" %in% ls()){
  SCC <- readRDS("Source_Classification_Code.rds")
}

# Subset Baltimore data
baltimore <- subset(NEI, fips == '24510')

# Find code corresponding to motor-vehicle related source
motoVehSCC1 <- as.character(SCC$SCC[grep('Motor.*Veh', SCC$Short.Name)])
motoVehSCC2 <- as.character(SCC$SCC[grep('Veh.*Motor', SCC$Short.Name)])
motoVehSCC <- unique(c(motoVehSCC1, motoVehSCC2))

# Subset motor-vehicle related data
motoVehBalt <- subset(baltimore, SCC %in% motoVehSCC)

totalEmission <- tapply(motoVehBalt$Emissions, motoVehBalt$year, sum, na.rm=TRUE)
year <- as.Date(as.character(unique(motoVehBalt$year)), '%Y')

png(filename = 'plot5.png', width = 480, height = 480, units = 'px')
plot(year, totalEmission, type="l", pch=20, cex=2, col='blue', xlab = 'Year',
     ylab = 'Total PM 2.5 Emission (ton)',
     main = "Motor vehicle PM 2.5 emission in Baltimore City")
dev.off()