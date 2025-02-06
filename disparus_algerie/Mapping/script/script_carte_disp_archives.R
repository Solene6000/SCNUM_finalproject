## Script pour map "Archives relatives aux civil•es européen•nes disparu•es durant la Guerre d'Algérie 1954-1962"

## Install necessary packages for the project
install.packages("leaflet")
install.packages("sp")
install.packages("sf")

# Load the required libraries for mapping and spatial data manipulation
library(leaflet)
library(sp)
library(sf)

# Load the shapefile
lieux <- st_read('disparus_algerie/Mapping/shp/lieux_reseaux_shp/lieux_disparition.shp')

carte <- st_read('disparus_algerie/Mapping/shp/carte_algerie_shp/carte_algerie.shp')

# Read the CSV file containing data
data_lieux <- read.csv("disparus_algerie/Mapping/csv/data_lieux.csv")

data_archives <- read.csv("disparus_algerie/Mapping/csv/data_archives.csv")

# Initialize the leaflet map with the shapefile data
map <- leaflet(lieux) %>% 
  ## Add the base map layer
  addProviderTiles(providers$OpenStreetMap)  %>% 
  
  ## Set the initial view of the map (center and zoom level)
  setView(lng = 3.08746, 
          lat = 36.73225, 
          zoom = 4 ) %>%
  
  ## Add markers using the latitude and longitude columns from the CSV
  addMarkers(data = data_lieux,
             lng = ~lng, 
             lat = ~lat,
             clusterOptions = markerClusterOptions(
               spiderfyOnMaxZoom = TRUE,
               showCoverageOnHover = FALSE,
               zoomToBoundsOnClick = TRUE),
             group = "lieu de disparition",
             popup = ~paste("Lieu de disparition :", "<b>", label,"</b>","<br>",
                            "Nombre de disparu•es :","<b>",value,"</b>","<br>",
                            "Localisation des archives :","<b>",archives,"</b>",
                            sep = " ")) %>%
  
  addMarkers(data = data_archives,
             lng = ~lng, 
             lat = ~lat,
             group = "archives",
             popup = ~paste("<b>", label,"</b>","<br>",
                            "Nombre de dossiers de personnes disparues :","<b>",
                            nb_dossiers,"</b>","<br>",
                            sep = " ")) %>%
  
  ## Add a polygon layer 
  addPolygons(data = lieux, 
              color = "#008000", 
              weight = ~(size / max(size) * 10), 
              smoothFactor = 0,
              group = "Lieux",
              label = ~paste(lieux$label, ": ", lieux$size, " disparu•es ")) %>%
  
  addPolygons(data = carte, 
              color = "lightblue", 
              weight = 1, 
              smoothFactor = 0,
              group = "Frontieres actuelles",
              label = ~paste(carte$NAME_1, " - ", carte$NL_NAME_1, carte$VARNAME_1)) %>%
  
  ## Add a legend to the top right of the map with custom colors and labels
  addLegend("topright", 
            colors = c("transparent"), 
            labels = c("Les astérisques (*) indiquent une estimation du lieu de disparition. <br>Source : site Mémoire des hommes."),
            title = "Archives relatives aux civil•es européen•nes disparu•es durant la Guerre d'Algérie 1954-1962") %>%
  
  
  ## Add layer control allowing users to toggle between overlay groups
  addLayersControl(overlayGroups = c("lieu de disparition", "archives"),
                   options = layersControlOptions(collapsed = TRUE))

## Render the map
map
