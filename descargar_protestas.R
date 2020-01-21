rm(list=ls(all=T))

library(gdeltr2)
library(dplyr)
library(lubridate)
library(haven)

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

#Creamos una tibble vacía con los nombres de las columnas y los tipos de variables:
df <- head(readRDS(file = filenames[1]), n = 0)

# L I M P I E Z A
for (archivo in filenames){
  x <-readRDS(file = archivo)
  x <-x %>% filter(idCAMEOEventRoot == 14) #Nos quedamos unicamente con las protestas
  df <- bind_rows(df, x)
  rm(x)
}

save(df, file = "protestas2019.RData")