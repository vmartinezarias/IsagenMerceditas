# IsagenMerceditas
# Códigos para análisis de Datos en Termocentro

El primer paso es construir la matriz. Esta debe tener la forma que se ha otorgado en la plantilla, y debe ser salvada en un directorio solitario en formato csv, con el nombre "curvas_meta_gtaxonomico.csv"

Para ejecutar el Código adecuadamente, el primer paso es cuadrar el directorio de trabajo (donde se encuentran nuestros archivos)

``` { r}

setwd("Directorio")

```

Si los paquetes no están instalados, se hace de la siguiente forma:

``` { r}

install.packages("iNEXT")
install.packages("ggplot")

```

Cargar paquetes requeridos... 


``` { r}

library(iNEXT)
library(ggplot2)


```

# Datos de abundancia (Aves, Mamíferos, Herpes)
En sistemas Windows (c) es necesario verificar primero que los archivos, efectivamente fuesen guardados como separados por coma (sep=","). Esto se mira, observando el archivo de entrada en el block de notas. También, se puede aprovechar y mirar el separador decimal. Es importante agregar que el separador de texto, no puede ser el mismo que el separador decimal (dec=)


Para insectos, simplemente cambiar el valor de datatype="abundance" por datatype="incidence_raw".

El comando +scale_shape_manual(values=seq(0,10)) indica que se grafican 10 curvas. Si se va a hacer sobre el total, el valor debe ser: 0,total (números, obviamente)

``` { r}
datos<-read.csv2("curvas_meta_gtaxonomico.csv", sep=",", dec=".")
curva_datos<-iNEXT(datos, q=0, datatype="abundance", size=NULL, endpoint=NULL, knots=50, se=TRUE, conf=0.95, nboot=5000)
curvaplot_datos<-ggiNEXT(curva_datos, type=1, se=TRUE, facet.var="none", color.var="site", grey=TRUE)
curvaplot_datos + labs(x = "Unidad", y = "Diversidad de especies") +scale_shape_manual(values=seq(0,10)) + geom_jitter(aes(color = site), size = 1, show.legend = FALSE) + 
  facet_wrap(~ site) + theme(legend.position = "none")

```
#Para graficar la completitud del muestreo
Esta curva indica qué tan completo es el muestreo en términos del tamaño de la muestra.

``` { r}
completitud_datos<-ggiNEXT(curva_datos, type=2, facet.var="none", color.var="site", se=FALSE, grey=TRUE)
completitud_datos + labs(x = "Sample unit", y = "Sample coverage") + geom_jitter(aes(color = site), size = 1, show.legend = FALSE) + 
  facet_wrap(~ site)  + theme(legend.position = "none")
```

Para exportar el archivo:

``` {r}
as.dataframe(curvaestacion_abund)
write.table(curva_datos["AsyEst"], "indexes.csv", sep="\t")
```


