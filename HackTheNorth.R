######################################

rm(list=ls(all=TRUE))

library(dplyr)
library(readr)
library(leaflet)
library(dplyr)
library(ggplot2)
library(KernSmooth)
library(forecast)

bulk <- read_csv("~/Desktop/bulk.csv")
Middle_Layer_2011 <- read_csv("~/Desktop/Middle_Layer_Super_Output_Areas_December_2011_Population_Weighted_Centroids.csv")

head(bulk)
head(Middle_Layer_2011)

names(bulk)
names(Middle_Layer_2011)

colnames(Middle_Layer_2011) <- c("X",        "Y",        "objectid", "geography code", "msoa11nm")

data.f1 <- bulk 
data.f2 <- Middle_Layer_2011

str(data.f1)
str(data.f2)

data.census.2011 <- inner_join(x = data.f1, y = data.f2, by="geography code")

names(data.census.2011)

table(data.census.2011$msoa11nm)

sorted.data <- sort(data.census.2011$msoa11nm)
sorted.data[4000:4500]

data.census.2011$msoa11nm <- sort(data.census.2011$msoa11nm)

#Districts: 
##City of Manchester
#Stockport
#Tameside
#Oldham
#Rochdale
#Bury
#Bolton
#Wigan
#City of Salford
#Trafford

new.data <- filter( data.census.2011, by msoa11nm )

#######################################################
# Map 
#######################################################

leaflet(data.census.2011) %>%
  addTiles() %>%
  addMarkers(lat = ~Y, lng = ~X)

dim(data.census.2011)

leaflet(data.census.2011) %>% addTiles() %>%
  addMarkers(lat = ~Y, lng = ~X ,
             clusterOptions = markerClusterOptions() ) 


leaflet(data.census.2011) %>% addTiles() %>%  addCircles(~X, ~Y, popup=data.census.2011[,5], weight = 3, radius=40, 
                                             color="black", stroke = TRUE, fillOpacity = 0.8) 


#######################################################

