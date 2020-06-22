setwd("Directorio")

# Si no se han instalado 


# Cargar paquetes requeridos 
require(iNEXT)
library(ggplot2)

# DATOS DE ABUNDANCIA
datos<-read.csv2("curvas_meta_gtaxonomico.csv", sep=",", dec=".")
curva_datos<-iNEXT(datos, q=0, datatype="abundance", size=NULL, endpoint=NULL, knots=50, se=TRUE, conf=0.95, nboot=5000)
curvaplot_datos<-ggiNEXT(curvadatos, type=1, se=TRUE, facet.var="none", color.var="site", grey=TRUE)
curvaplot_datos + labs(x = "Unidad", y = "Diversidad de especies") +scale_shape_manual(values=seq(0,10)) + geom_jitter(aes(color = site), size = 1, show.legend = FALSE) + 
  facet_wrap(~ site) + theme(legend.position = "none")

summary(curvaplotestacion_abund)

#Para graficar la completitud del muestreo
completitud_datos<-ggiNEXT(curva_datos, type=2, facet.var="none", color.var="site", se=FALSE, grey=TRUE)
completitud_datos + labs(x = "Sample unit", y = "Sample coverage") + geom_jitter(aes(color = site), size = 1, show.legend = FALSE) + 
  facet_wrap(~ site)  + theme(legend.position = "none")

as.dataframe(curvaestacion_abund)
write.table(curva_datos["AsyEst"], "indexes.csv", sep="\t")