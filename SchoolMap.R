library(highcharter)
library(plyr)
library(ggmap)
library(maptools)

SchoolCoordinates <- getKMLcoordinates("data/APS_Schools.kml", ignoreAltitude=TRUE)
dfPoints <- data.frame(
  long = SchoolCoordinates[[1]][,1],
  lat = SchoolCoordinates[[1]][,2]
)
dat.pts <- data.frame(x = dfPoints$long, y = dfPoints$lat)
map <- get_googlemap(
  "Albuquerque" # google search string
  , zoom = 12 # larger is closer
  , maptype = "roadmap" # map type
  #, markers = dat.pts # markers for map
  , path = dfPoints # path, in order of points
  , scale = 2
)

p <- ggmap(map
           , path = dat.pts # path, in order of points
           , extent = "device" # remove white border around map
           , darken = 0.2 # darken map layer to help points stand out
)
#p <- p + geom_text(data = dat, aes(x = long, y = lat, label = location)
#                   , hjust = -0.2, colour = "white", size = 6)
p <- p + labs(title = "Energy Use per Student by School")
print(p)
