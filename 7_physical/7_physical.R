
library(tidyverse)
library(reshape2)

df <- melt(volcano)

ggplot(df, aes(Var1, Var2, z = value)) + 
  geom_contour_filled() +
  theme_void() +
  theme(legend.position = "none")

#Save the most recent chart as an image (inches is default)
ggsave("7_physical/7_physical.png", device = "png", type = "cairo", width = 8, height = 6) #Use device= and type= to stop images being pixelated
