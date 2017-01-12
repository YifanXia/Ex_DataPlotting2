library(ggplot2)

# Read the emission data & source classification code
if (!"NEI" %in% ls()){
        NEI <- readRDS("summarySCC_PM25.rds")
}
if (!"SCC" %in% ls()){
        SCC <- readRDS("Source_Classification_Code.rds")
}

# Subset Baltimore & L.A. data
BLA <- subset(NEI, fips %in% c('24510', '06037'))

# Find code corresponding to motor-vehicle related source
motoVehSCC1 <- as.character(SCC$SCC[grep('Motor.*Veh', SCC$Short.Name)])
motoVehSCC2 <- as.character(SCC$SCC[grep('Veh.*Motor', SCC$Short.Name)])
motoVehSCC <- unique(c(motoVehSCC1, motoVehSCC2))

# Subset motor-vehicle related data
motoVehBLA <- subset(BLA, SCC %in% motoVehSCC)

motoVehBLA_agg <- aggregate(motoVehBLA$Emissions, 
                            list('fips' = motoVehBLA$fips, 'year'= motoVehBLA$year),
                            FUN=sum, na.rm=TRUE)

png(filename = 'plot6.png', width = 480, height = 480, units = 'px')
g <- ggplot(motoVehBLA_agg, aes(year, x, col=fips))
g + geom_line() + 
  labs(title = "Motor vehicle PM 2.5 emission in Los Angeles Baltimore City") +
  labs(x = "Year", y = "PM 2.5 emission (ton)") +
  scale_colour_discrete(name = 'City', labels = c("Los Angeles County", "Baltimore City"))
dev.off()