

# PAQUETES A UTILIZAR -----------------------------------------------------


## INSTALACIÓN -------------------------------------------------------------
## Instalación de paquetes a utilizar en el Capítulo 2



## CARGA DE PAQUETES -------------------------------------------------------
## Cargando paquetes a utilizar en el Capítulo 2

library(tidyverse)
library(magrittr)
library(datos)
library(datasets)



# CREACIÓN DE GRÁFICOS -------------------------------------------------

## DATA ------------------------------------------------------------
## Elegimos la Data
profesores2 %>% ggplot()

## Algunos conjuntos de datos de los paquetes 'datos'
## y 'datasets'
library(help = "datos")
view(diamantes)
view(paises)
view(presidencial)
view(millas)

library(help = "datasets")
view(economics)


## ESTÉTICA ----------------------------------------------------------------
## Especificamos las variables con aes()
profesores2 %>% ggplot(aes(edad))


## GEOMETRÍAS --------------------------------------------------------------
## Definimos el tipo de gráfico con geom_
## En este caso tenemos un gráfico de barras
profesores2 %>% ggplot(aes(edad)) +
    geom_bar()


## FACETAS -----------------------------------------------------------------
## facet_grid()

## facet_grid(. ~ var1) ordena por columnas
profesores2 %>% ggplot(aes(edad)) +
    geom_bar() +
    facet_grid(.~niveldocencia)

## facet_grid(var1 ~ .) ordena por filas
profesores2 %>% ggplot(aes(edad)) +
    geom_bar() +
    facet_grid(niveldocencia~.)

## facet_grid(var1 ~ var2) compara dos variable categóricas
## v1 por filas, v2 por columnas
profesores2 %>% ggplot(aes(edad)) +
    geom_bar() +
    facet_grid(niveldocencia~tiempo)

## facet_wrap()
profesores2 %>% ggplot(aes(edad)) +
    geom_bar() +
    facet_wrap(~niveldocencia)

profesores2 %>% ggplot(aes(edad)) +
  geom_bar() +
  facet_wrap(~niveldocencia, nrow = 2)

# PRÁCTICA 4.1 --------------------------------------------------------------

## 1. Observe el dataset `millas`.

millas %>% ggplot(aes(x=cilindrada, y = autopista))+
  geom_smooth()
  
millas %>% ggplot(aes(x=cilindrada, y = autopista))+
  geom_point() + 
  facet_grid(.~traccion)

## Replique el siguiente gráfico


unique(millas$cilindrada)
unique(millas$autopista)

colnames(millas)


## MÁS ESTÉTICAS -------------------------------------------------------

## más de 1 geometría, 1 gráfico de puntos y un gráfico
## de líneas suavizadas
millas %>% ggplot(aes(x = cilindrada, y = autopista)) +
    geom_point() +
    geom_smooth()

## introducir más variables en el gráfico de puntos
millas %>% ggplot(aes(x = cilindrada, 
                      y = autopista)) +
    geom_point(aes(color = clase,
                   shape = traccion)) +
    geom_smooth()

## Transformar la data de una de las geometrías
millas %>% ggplot(aes(x = cilindrada, 
                      y = autopista)) +
    geom_point(aes(color = clase,
                   shape = traccion)) +
    geom_smooth(data = filter(millas, 
                              fabricante == "toyota"))


colnames(millas)

# PRÁCTICA 4.2 ------------------------------------------------------------

## Recrea el código R necesario para generar el 
## siguiente gráfico

millas %>% ggplot(aes(x = cilindrada, 
                      y = autopista)) +
  geom_point(aes(color = traccion)) +
  geom_smooth(aes(linetype = traccion), se=FALSE)

unique(millas$traccion)


## TRANSFORMACIONES ESTADÍSTICAS -------------------------------------------

view(diamantes)

buenosD <- diamantes %>% 
  filter(corte=="Bueno" & color=="D")

buenosD %>% ggplot(aes(x=quilate, y=precio)) +
  geom_point() +
  geom_line() +
  geom_smooth()

buenosD %>% ggplot(aes(x=quilate, y=precio)) +
  geom_point() +
  geom_line() +
  geom_smooth(method = 'lm')

buenosD %>% ggplot(aes(x=quilate, y=precio)) +
  geom_point() 

buenosD %>% ggplot(aes(x=quilate, y=precio)) +
  geom_point(stat = "identity")


buenosD %>% ggplot(aes(x=quilate, y=precio)) +
  geom_point(stat = "smooth")

buenosD %>% ggplot(aes(x=quilate, y=precio)) +
  geom_smooth(stat = "identity")


## gráfico de barras
diamantes %>% ggplot(aes(x = corte)) +
    geom_bar()

buenosD %>% ggplot(aes(x = claridad)) +
  geom_bar()

## el mismo gráfico con stat_count()
diamantes %>% ggplot(aes(x = corte)) +
    stat_count()

buenosD %>% ggplot(aes(x = claridad)) +
  stat_count()


## Muestra un gráfico de barras de proporciones, 
## en lugar de un recuento
## especificar en el eje y = stat(prop) y group=1
diamantes %>% ggplot(aes(x = corte, 
                         y=stat(prop), 
                         group=1)) +
    stat_count()


buenosD %>% ggplot(aes(x = claridad, 
                       y=stat(prop), 
                       group=1)) +
  stat_count()

## Usar `stat_summary()` para resumir los valores
## de $y$ para cada valor único de $x$,
diamantes %>% ggplot(aes(x = corte, 
                         y=profundidad)) +
    stat_summary(fun.min = min,
                 fun.max = max,
                 fun = median)

buenosD %>% ggplot(aes(x = claridad,
                       y = precio)) +
  geom_point(alpha=0.3,  
             color="turquoise4") +
  stat_summary(fun.min = min, 
               fun.max = max,
               fun=median, 
               size=0.8, 
               color="salmon")

# Histograma
## De frecuencias absolutas
buenosD %>% ggplot(aes(x=precio)) +
  geom_histogram(aes(y=stat(count)),
                 binwidth = 3000,
                 color="ivory",
                 fill="thistle3") +
  geom_freqpoly(aes(y=stat(count)),
                binwidth = 3000,
                color="purple",
                size =1) +
  geom_text(stat = "bin",
            binwidth= 3000,
            aes(label=stat(round(count,2)),
                y=stat(count)),
            nudge_y = 5)


buenosD %>% ggplot(aes(y=precio)) +
  geom_histogram(aes(x=stat(count)),
                 binwidth = 3000,
                 color="ivory",
                 fill="thistle3") +
  geom_freqpoly(aes(x=stat(count)),
                binwidth = 3000,
                color="purple",
                size =1) +
  geom_text(stat = "bin",
            binwidth= 3000,
            aes(label=stat(round(count,2)),
                x=stat(count)),
            nudge_y = 5)




min(buenosD$precio)
max(buenosD$precio)

# COORDENADAS Y ESCALAS ---------------------------------------------------

## COORDENADAS -------------------------------------------------------------

## coord_flip
diamantes %>% ggplot(aes(x = corte, 
                         y = precio)) +
    geom_boxplot()

## coord_flip
diamantes %>% ggplot(aes(x = corte, 
                         y = precio)) +
    geom_boxplot() +
    coord_flip()

## coord_polar
diamantes %>% ggplot(aes(x = corte)) +
    geom_bar() +
    coord_flip()

## coord_polar
diamantes %>% ggplot(aes(x = corte)) +
    geom_bar() +
    coord_polar()


# TEMAS -----------------------------------------------------------------

## temas predeterminados
diamantes %>% ggplot(aes(x = corte)) +
    geom_bar() +
    coord_polar() +
    theme_void()

`theme_grey()`
`theme_bw()`
`theme_light()`
`theme_dark()`
`theme_classic()`
`theme_void()`

## color al gráfico
diamantes %>% ggplot(aes(x = corte, fill=corte)) +
    geom_bar() +
    coord_polar() +
    scale_fill_brewer()


## etiquetas de títulos con labs()
diamantes %>% ggplot(aes(x = corte, fill=corte)) +
    geom_bar() +
    coord_polar() +
    scale_fill_brewer() +
    theme(legend.position = "bottom") +
    labs(title = "La cantidad de diamantes por tipo de corte",
             subtitle = "Mayor cantidad de diamantes de corte ideal",
             caption = "Datos de R.com")

library(RColorBrewer)
colors()
display.brewer.all()

diamantes %>% ggplot(aes(x = corte, fill=corte)) +
    geom_bar() +
    coord_polar() +
    scale_fill_brewer(palette = "Set2") +
    theme(legend.position = "bottom") +
    labs(title = "La cantidad de diamantes por tipo de corte",
         subtitle = "Mayor cantidad de diamantes de corte ideal",
         caption = "Datos de R.com")


## gráfico con varios atributos
diamantes %>% ggplot(aes(x = corte, 
                         fill=corte)) +
    geom_bar(alpha=0.8) +
    scale_fill_brewer(palette = "Dark2") +
    geom_text(aes(label=..count..), 
              stat = 'count',
              vjust=-0.5) +
    theme_minimal() +
    theme(legend.position = "bottom") +
    labs(x = "Corte del diamante",
         y = "Cantidad de diamantes",
         title = "La cantidad de diamantes por tipo de corte",
         subtitle = "Mayor cantidad de diamantes de corte ideal",
         caption = "Datos de R.com",
         fill = "Tipo de corte")


## para guardar el gráfico
## 1. guardar el gráfico en un objeto

grafico1 <- diamantes %>% ggplot(aes(x = corte, 
                                     fill=corte)) +
    geom_bar(alpha=0.8) +
    scale_fill_brewer(palette = "Dark2") +
    geom_text(aes(label=..count..), 
              stat = 'count',
              vjust=-0.5) +
    theme_minimal() +
    theme(legend.position = "bottom") +
    labs(x = "Corte del diamante",
         y = "Cantidad de diamantes",
         title = "La cantidad de diamantes por tipo de corte",
         subtitle = "Mayor cantidad de diamantes de corte ideal",
         caption = "Datos de R.com",
         fill = "Tipo de corte")


ggsave(filename = "imagenes/grafico1.png",
       plot = grafico1,
       units = "cm",
       height   = 21,
       width = 29.7)



datos::presidencial

presidencial %>% view

datos::datos_credito

datos_credito %>% view()

datos_credito %>% ggplot(aes(x = Trabajo, 
                         fill=Estado)) +
  geom_bar(alpha=0.8) +
  scale_fill_brewer(palette = "Dark2") +
  geom_text(aes(label=..count..), 
            stat = 'count',
            nudge_y = 100) +
  theme_minimal() +
  theme(legend.position = "bottom") +
  labs(x = "Tipo del Trabajo de los clientes",
       y = "Estado del créditos de los clientes",
       title = "Clasificación de los clientes por su trabajo y estado de crédito",
       caption = "Datos de R.com",
       fill = "Tipo de trabajo")


  ?datos_credito


# Practice 4.3 ------------------------------------------------------------

## 1. Construct a graph according to the grammar of graphs.ggplot2


# R Markdown --------------------------------------------------------------

install.packages("tinytex", dependencies = TRUE)
install.packages("knitr", dependencies = TRUE)
install.packages('rmarkdown')
install.packages("tufte")

