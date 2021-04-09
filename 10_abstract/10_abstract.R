
library(tidyverse)
library(ggfx)

#Generate data frame with random numbers
dataset <- data.frame(x=rnorm(1000), y=rnorm(1000))

#plot data
p1 <- ggplot(dataset, aes(x,y)) +
  geom_line(colour="purple") + 
  with_blur(geom_point(shape=8, colour="yellow", size=3),
            sigma = unit(0.5, 'mm')
            ) +
  theme_void() +
  coord_polar() + 
  theme(plot.background = element_rect(fill = "black", color = "black"))

ggsave(p1, "10_abstract/10_abstract.png", plot = p1, device = "png", type = "cairo", width = 8, height = 8) #Use device= and type= to stop images being pixelated


dataset2 <- data.frame(x=rnorm(1000), y=rnorm(1000))

#plot data
p2 <- ggplot(dataset2, aes(x,y)) +
  geom_path(colour="blue") + 
  with_blur(geom_point(shape=8, colour="red", size=3),
            sigma = unit(0.5, 'mm')
  ) +
  theme_void() +
  coord_polar() + 
  theme(plot.background = element_rect(fill = "black", color = "black"))
p2

ggsave("10_abstract/10_abstract2.png", plot = p2, device = "png", type = "cairo", width = 8, height = 8) #Use device= and type= to stop images being pixelated

dataset3 <- data.frame(x=rnorm(1000), y=rnorm(1000))

#plot data
p3 <- ggplot(dataset3, aes(x,y)) +
  geom_line(colour="turquoise") + 
  with_blur(geom_point(shape=8, colour="orange", size=3),
            sigma = unit(0.5, 'mm')
  ) +
  theme_void() +
  coord_polar() + 
  theme(plot.background = element_rect(fill = "black", color = "black"))
p3

ggsave("10_abstract/10_abstract3.png", plot = p3, device = "png", type = "cairo", width = 8, height = 8) #Use device= and type= to stop images being pixelated
