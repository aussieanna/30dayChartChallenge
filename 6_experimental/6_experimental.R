
library(tidyverse)
library(readxl)
library(ggfx)

#Import data
rand <- read_excel("6_experimental/random.xlsx")

ggplot(rand, aes(x,y, colour=y)) + 
  with_blur(
    geom_point(size=3),
    sigma = unit(0.5, 'mm')
  ) +
  coord_polar() + 
  theme_void() + 
  scale_colour_gradientn(colours=rainbow(4)) + 
  theme(legend.position = "none",
        plot.background = element_rect(fill = "black", color = "black"))

ggsave("6_experimental/6_experimental.png", device = "png", type = "cairo", width = 8, height = 8) #Use device= and type= to stop images being pixelated
