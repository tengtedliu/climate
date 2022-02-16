rm(list=ls())


library(tidyverse)
library(urbnmapr)
library(usmap)
library(readxl)
library(sf)
library(ggplot2)
library(tmap)
library(tmaptools)
library(leaflet)
library(ggmap)
library(dplyr)
library(stringr)
library(scales)
library(gganimate)
library(gifski)
library(usmap)
library(tigris)
library(viridis)
library(foreign)
library(urbnthemes)
library(plotly)


set_urbn_defaults(style = "map")


df <- read.csv(file = 'county_map_m2.csv')


states_sf <- get_urbn_map("states", sf = TRUE)
counties_sf <- get_urbn_map("counties", sf = TRUE)
counties_sf$county_fips <- as.integer(counties_sf$county_fips)

typeof(lendnum$county_fips)
typeof(counties_sf$county_fips)

spatial_data_m <- left_join(counties_sf,
                            df,
                            by = "county_fips")


####percentage of small farms
png("map36.png", width = 762, height = 507)
ggplot() +
  geom_sf(data=spatial_data_m %>%
            filter(state_name != "Hawaii" & state_name != "Alaska"),mapping = aes(fill = psmall),
          color = "#1696d2", size = 0.05) +
  geom_sf(data=states_sf %>% filter(state_name != "Hawaii" & state_name != "Alaska"), fill = NA, color="#ffffff") +
  coord_sf(datum = NA) +
  scale_fill_gradientn(labels = scales::number) +
  labs(fill = "Share of small farms")
dev.off()
