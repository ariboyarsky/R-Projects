rm(list = ls())

library(ggplot2)
library(rgeos)
library(plyr)
library(scales)
library(maptools)
require(graphics)
library(ggthemes)
library(colorspace)

US_GINI_Data <- read.csv("~/College/Senior/Sem 1/Modeling and Visulizing Politics/RVisulization/US Census Data Intra-US GINI/ACS_15_1YR_B19083_with_ann.csv")

#state data
states_map <- map_data("state")

#Let's give better names
colnames(US_GINI_Data) <- c("GEO.id", "GEO.id2", "state", "GINI", "GINI2")

#change to lower case
gini <- as.data.frame(lapply(US_GINI_Data, tolower), stringsAsFactors = FALSE)
#we have to trasform GINI to num
gini <- transform(gini, GINI = as.numeric(GINI))

#megre map data and GINI data
gini_map <- merge(states_map, gini, by.x = "region", by.y = "state")

#create map, g
g <- ggplot(data=gini_map, mapping = aes(x=long, y=lat, group=group))+
  geom_polygon(aes(fill=GINI))+
  geom_path()

remove_axes <- theme(
  axis.text = element_blank(),
  axis.line = element_blank(),
  axis.ticks = element_blank(),
  panel.border = element_blank(),
  panel.grid = element_blank(),
  axis.title = element_blank()
)

g <- g+remove_axes+ggtitle('GINI Accross the United States')
g <- g+scale_fill_distiller(name="GINI", palette = "YlGnBu", breaks = pretty_breaks(n = 5))
g

gini

