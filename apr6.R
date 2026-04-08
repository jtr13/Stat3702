library(tidyverse)
library(sf)
library(readxl)

nypp <- read_sf("nypp_25c/nypp.shp")

head(nypp)
tail(nypp)

ggplot(nypp) +
  geom_sf() +
  geom_sf_text(aes(label = Precinct), size = 2) +
  theme_void()

ny_crime <- read_xls("felony.xls", skip = 2) |> 
  fill(PCT) |> 
  filter(CRIME == "ROBBERY") |> 
  select(Precinct = PCT, CRIME, Robbery = `2021`) |> 
  mutate(Precinct = as.numeric(Precinct))

plot_data <- left_join(nypp, ny_crime)

ggplot(plot_data) +
  geom_sf(aes(fill = Robbery)) + 
  geom_sf_text(aes(label = Precinct), size = 2,
               color = "white") +
  theme_void()
