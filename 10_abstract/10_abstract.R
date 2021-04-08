
library(tidyverse)
library(ggfx)

#Generate data frame with random numbers
dataset <- data.frame(x=rnorm(1000), y=rnorm(1000))

#plot data
ggplot(dataset, aes(x,y)) +
  geom_line(colour="purple") + 
  with_blur(geom_point(shape=8, colour="yellow", size=3),
            sigma = unit(0.5, 'mm')
            ) +
  theme_void() +
  coord_polar() + 
  theme(plot.background = element_rect(fill = "black", color = "black"))

ggsave("10_abstract/10_abstract.png", device = "png", type = "cairo", width = 8, height = 8) #Use device= and type= to stop images being pixelated
