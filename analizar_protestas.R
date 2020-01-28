rm(list=ls(all=T))

library(extrafont)
extrafont::loadfonts(device = "win")

library(lubridate)
library(tidyverse)
library(magick)
library(gdeltr2)

loadfonts(device = "win")

load(file = "protestas2019.RData")

diccionario <-dictionary_geo_codebook(code_book = "countries")
diccionario <- diccionario %>% select(idCountry,value) 
diccionario <- diccionario %>% rename(idCountryAction = idCountry)

###############################################
#Gráfica 1: Países más mencionados

paises <- df %>%
  filter(is.na(idCountryAction) == FALSE) %>%
  count(idCountryAction, sort = T) %>%
  top_n(15)

paises <- paises %>% inner_join(.,diccionario)
paises <- paises %>% rename(territorio = value)


g1 <-paises %>% ggplot(aes(x = fct_reorder(territorio,n, .desc=T),
                           y = n)) +
  geom_col(stat=identity, fill =  "#347B98", alpha = 0.8) +
  #coord_flip() +
  labs (title = "Territorios con más protestas durante 2019",
        subtitle= "Territorios con más protestas registradas por GDELT entre el 1 de enero y el 31 de diciembre de 2019",
        caption = " Fuente: Elaboración propia con datos de GDELT \n @santivalenz // @masquedata",
        x = NULL,
        y = NULL) +
  
  scale_x_discrete(expand = c(0,0)) + 
  
  theme_minimal() +
  theme(text = element_text(family="Segoe UI"),
        plot.title = element_text(hjust = 0, size = 18, face = "bold", color= "#347B98"),
        plot.subtitle = element_text(hjust = 0, size = 11),
        plot.caption = element_text(hjust = 0, size = 12),
        axis.text.x=element_text(hjust=0, angle = -45))

##############################################
#Gráfica 2: Principales medios

medios <- df %>%
  count(nameSource, sort = T) %>%
  top_n(15)
  
g2 <-medios %>% ggplot(aes(x = fct_reorder(nameSource,n),
                      y = n)) +
  geom_col(stat=identity, fill =  "#347B98", alpha = 0.8) +
  coord_flip() +
  labs (title = "Medios más citados por GDELT",
        subtitle= "Número de veces que el medio es usado como fuente para reportar protestas \nen la base de datos de GDELT para el año 2019",
        caption = " Fuente: Elaboración propia con datos de GDELT \n @santivalenz // @masquedata",
        x = NULL,
        y = NULL) +
  
  scale_x_discrete(expand = c(0,0)) + 
  scale_y_continuous(expand = c(0,0)) +
  
  theme_minimal() +
    theme(text = element_text(family="Segoe UI"),
          plot.title = element_text(hjust = 0, size = 18, face = "bold", color= "#347B98"),
          plot.subtitle = element_text(hjust = 0, size = 11),
          plot.caption = element_text(hjust = 0, size = 12),
          axis.text.x=element_text(hjust=0))
