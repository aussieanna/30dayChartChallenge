
library(tidyverse)
library(readxl)
library(ggfx)

#Import data
hp_films <- read_excel("4_magical/harry_potter_ratings.xlsx")

purple <- "#800080"
#Make lollipop chart
hp_films %>% 
  ggplot(aes(x=reorder(Title, Rating), y=Rating)) +
  geom_segment( aes(x=Title, xend=Title, y=0, yend=Rating), colour=purple) + 
  with_blur(geom_point(size = 3, colour="yellow"),
            sigma = unit(1, 'mm')
  ) + 
  coord_flip() +
  labs(y= "Rating (per cent)", x=" ", caption = "Data: Rotten Tomatoes", title = "Ratings of the Harry Potter Franchise Movies") + 
  theme_minimal() +
  theme(plot.title.position = "plot",
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        text = element_text(family = "Arial", face = "plain", colour = "white"),
        axis.text = element_text(size = rel(0.8), colour = "white"),
        plot.background = element_rect(fill = "black", color = "black"))

ggsave("4_magical/4_magical.png", device = "png", type = "cairo", width = 8, height = 6) #Use device= and type= to stop images being pixelated
