rm(list=ls(all=T))

library(gdeltr2)
library(dplyr)
library(lubridate)

# D E S C A R G A 

#Generamos el listado de fechas
fechas <- seq(ymd('2019-01-01'),ymd('2019-12-31'),by='days')
fechas <- gsub("-","",fechas) #Quitamos los guiones

filenames <- paste0("./downloads/RDS_", fechas,".RData")

descarga <- function(dias){
  for(dia in 1:(length(dias))){
    x <- get_data_gdelt_periods_event(period = dias[dia])
    saveRDS(x, file = filenames[dia])
    y <-paste0("Guardado", dias[dia])
    print(y)
    rm(x)
    Sys.sleep(25)
  }
}

#descarga(fechas)

# L I M P I E Z A

#Creamos una tibble vacía con los nombres de las columnas y los tipos de variables:
df <- head(readRDS(file = filenames[1]), n = 0)

#Unimos los archivos que descargamos
for (archivo in filenames){
  x <-readRDS(file = archivo)
  x <-x %>% filter(idCAMEOEventRoot == 14) #Nos quedamos unicamente con las protestas
  df <- bind_rows(df, x)
  rm(x)
}

save(df, file = "protestas2019.RData")

datos_mapa <- df %>%
  select(idGlobalEvent, dateEvent, dateFraction, idTypeLocationAction,
         locationAction, idCountryAction, latitudeAction, longitudeAction)

datos_mapa <- datos_mapa %>%
  arrange(dateFraction) %>%
  filter(dateFraction > 2019) %>%
  filter(idTypeLocationAction >= 3) %>%
  filter(is.na(latitudeAction) == FALSE)
  
saveRDS(datos_mapa, file = "datos_mapa.RData")
