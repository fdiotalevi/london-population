library(ggplot2)
library(maptools)

createPopulationGraphs <- function(dataDirectory, imagesDirectory, vectorOfYears) {  
  gpclibPermit()
  
  oldWd <- getwd()
  setwd(dataDirectory)
  
  population <- read.table("census-historic-population-borough.csv", sep=',', header=T, comment='', quote='')
  gb <- readShapeSpatial("district_borough_unitary_region.shp")
  
  london <- gb[gb$FILE_NAME == 'GREATER_LONDON_AUTHORITY',]

  #cleanup and prepare the london data
  london <- fortify(london)  
  london$borough <- gsub(" London Boro","",london$id)
  london$borough[london$borough=='City and County of the City of London'] <- 'City of London'
  london$borough[london$borough=='City of Westminster'] <- 'Westminster'
  
  #merge london data with population data  
  london <- merge(london, population, by.x=c("borough"), by.y=c("Area.Name"), all.x=T)
  cnames <- aggregate(cbind(long, lat) ~ borough, data=london, FUN=mean)
         
  for (year in vectorOfYears) {    
    plotId <- paste("year-", year, ".png", sep="")
    fillAccordingField <- paste("Persons", year, sep='.')
    plotTitle <- paste("London Population in ", year)    
    ggplot(london, aes(long,lat)) + geom_polygon(aes_string(group="group", fill=fillAccordingField)) + coord_equal() + xlab("") + ylab("") + 
      geom_text(data=cnames, aes(long, lat, label = borough), size=4, colour='white') +
      opts(title=plotTitle,axis.line=theme_blank(), axis.text.x=theme_blank(),
           axis.text.y=theme_blank(),axis.ticks=theme_blank(),plot.title = theme_text(size = 22))     
    ggsave(paste(imagesDirectory,plotId, sep='/'))
  }
  setwd(oldWd)
}




