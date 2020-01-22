rm(list=ls(all=T))

library(extrafont)
extrafont::loadfonts(device = "win")

library(dplyr)
library(lubridate)
library(maps)
library(ggplot2)
library(ggthemes)
library(gganimate)
library(maptools)

loadfonts(device = "win")

# V I S U A L I Z A C I Ó N
datos <-readRDS(file = "datos_mapa.RData")

data(wrld_simpl)

mundo <- ggplot(wrld_simpl,
            aes(x = long,
                y = lat,
                group = group)) +
  geom_polygon(fill = "#4424D6", color = "#110934", alpha= 0.9) +
  coord_map(projection = "mollweide")

mapa <-mundo +
  geom_point(aes(x = longitudeAction, y = latitudeAction, group= dateEvent),
             color = "#D4EDF7",
             alpha = 0.8,
             size = 1,
             data = datos) +
  
  labs(title= " 2019: un año de protestas",
       subtitle = " Fecha: {frame_time}",
       caption = " Fuente: Elaboración propia con datos de GDELT \n @santivalenz\n") +
  
  transition_time(dateEvent) + 
  exit_fade()+
  
  theme_void() +
  theme(text = element_text(color= "#D4EDF7", family="Segoe UI"),
        plot.background = element_rect(fill = "#347B98"),
        plot.title = element_text(hjust = 0, size = 18, face = "bold"),
        plot.subtitle = element_text(hjust = 0, size = 14),
        plot.caption = element_text(hjust = 0, size = 12))

animate(mapa, height = 600, width = 1000, nframes = 365)
anim_save("protestas_2019.gif")
