# protestas2019

Mapas y visualizaciones sobre las protestas ocurridas alrededor del mundo durante el año 2019, con datos de [GDELT](https://www.gdeltproject.org/).

Como su nombre lo indica, el archivo **descargar_protestas** descarga los datos del sitio web de GDELT y los une en un único archivo llamado **protestas2019.RData**. Los datos de este archivo son usados por **analizar_protestas**, y son la base de **datos_mapa.RData**, el cual es usado por **visualizar_protestas** para crear un mapa animado del mundo donde cada punto represente una protesta ocurrida durante el 2019. El resultado final es este:

![Protestas en el mundo en el 2019](protestas_2019.gif)
