# Read the emission data & source classification code
if (!"NEI" %in% ls()){
  NEI <- readRDS("summarySCC_PM25.rds")
}
if (!"SCC" %in% ls()){
  SCC <- readRDS("Source_Classification_Code.rds")
}

# Find code corresponding to coal combustion related source
coalCombSCC1 <- as.character(SCC$SCC[grep('Coal.*Comb', SCC$Short.Name)])
coalCombSCC2 <- as.character(SCC$SCC[grep('Comb.*Coal', SCC$Short.Name)])
coalCombSCC <- unique(c(coalCombSCC1, coalCombSCC2))
# Subset coal combustion related data
coalComb <- subset(NEI, SCC %in% coalCombSCC)

totalEmission <- tapply(coalComb$Emissions, coalComb$year, sum, na.rm=TRUE)
year <- as.Date(as.character(unique(coalComb$year)), '%Y')

png(filename = 'plot4.png', width = 480, height = 480, units = 'px')
plot(year, totalEmission, type="l", pch=20, cex=2, col='blue', xlab = 'Year',
     ylab = 'Total PM 2.5 Emission (ton)', main = 'U.S. Coal & Combustion PM 2.5 Emission')
dev.off()