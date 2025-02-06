## Script pour graph "Âges des civil•es disparu•es durant la guerre d'Algérie"

install.packages("ggplot2")
install.packages("plotly")
install.packages("GGally")

library(ggplot2)

table_ages <- read.csv("disparus_algerie/Graphs/data/data_disparus.csv")

ggplot(data = table_ages, aes(x = annee_disparition, 
                         size = nb_disparus_mm_annee,
                         colour = age_disparition,  
                         y = age_disparition))  +
  geom_point(alpha = 0.7) +  
  scale_colour_gradient(low = "blue", high = "red") +  
  scale_size_continuous(range = c(1, 10)) +
  labs(x = "Année de disparition", 
       y = "Âge au moment de la disparition",
       colour = "Âge au moment de la disparition",
       size = "Nombre total de disparu•es la même année",
       title = "Âges des civil•es disparu•es durant la guerre d'Algérie",
       subtitle = "Source : Site Mémoire des Hommes") +
  theme_classic()

