## Script pour graph "Disparitions de civil•es durant la guerre d'Algérie"

install.packages("ggplot2")
install.packages("dplyr")
install.packages("plotly")
install.packages("hrbrthemes")

library(ggplot2)
library(dplyr)
library(plotly)
library(hrbrthemes)

# Load the dataset from a CSV file and store it in the 'data' variable
data_disparus <- read.csv("disparus_algerie/Graphs/data/disparus_par_an.csv")

# Customize font properties for the plot
f <- list(
  family = "Arial, monospace",
  size = 14,
  color = "#7f7f7f"
)

# Customize x-axis properties
x <- list(
  title = "Année",
  titlefont = f
)

# Customize y-axis properties
y <- list(
  title = "Nombre de disparu•es",
  titlefont = f
)

# Add annotations to the plot
a <- list(
  text = "Source : Site Mémoire des hommes et 1000autres.org",
  xref = "paper",
  yref = "paper",
  yanchor = "bottom",
  xanchor = "center",
  align = "center",
  x = 0.8,
  y = 0.985,
  showarrow = FALSE
)

b <- list(
  text = "",
  font = f,
  xref = "paper",
  yref = "paper",
  yanchor = "bottom",
  xanchor = "center",
  align = "center",
  x = 0.5,
  y = 0.95,
  showarrow = FALSE
)

# Create an area chart with multiple groups
p <- plot_ly(x = data_disparus$annee_disparus_total, 
             y = data_disparus$disparus_europ,
             type = "bar", 
             name = "disparu•es européen•nes") 

p <- p %>% add_trace(y = data_disparus$disparus_alger, 
                     name = "disparu•es durant la bataille d'Alger (1957)") 


# Customize the layout of the plot
p <- p %>% layout(xaxis = x, 
                  yaxis = y, 
                  title = "Disparitions de civil•es durant la guerre d'Algérie", 
                  annotations = list(a, b))

# Display the plot
p
