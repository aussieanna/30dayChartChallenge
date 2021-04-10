
library(tidyverse)
library(extrafont)

#Import data

CBR <- read_csv("12_strips/IDCJAC0010_070351_2020/IDCJAC0010_070351_2020_Data.csv") %>% mutate(city = "Canberra")

Darwin <- read_csv("12_strips/IDCJAC0010_014015_2020/IDCJAC0010_014015_2020_Data.csv") %>% mutate(city = "Darwin")

Hobart <- read_csv("12_strips/IDCJAC0010_094008_2020/IDCJAC0010_094008_2020_Data.csv") %>% mutate(city = "Hobart")

#Combine datasets
combined <- rbind(CBR, Darwin, Hobart)

#Plot data
ggplot(combined, aes(x = city, y = `Maximum temperature (Degree C)`, colour = factor(city))) +
  geom_point(size = 1.5, position = "jitter", alpha = 0.5) +
  coord_flip() +
  theme_minimal() +
  scale_colour_viridis_d(guide=FALSE) +
  labs(title = "Range of maximum temperatures in Hobart, Darwin and Canberra, 2020",
       x = " ",
       y = "Degrees Celsius",
       caption = "Data: Australian Bureau of Meterology") +
  theme(plot.title.position = "plot", 
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        text = element_text(family = "Lato", face = "plain", colour = "black"),
        axis.text = element_text(size = rel(0.8), colour = "black"),
        plot.background = element_rect(fill = "grey", color = "grey"))

#Save the most recent chart as an image (inches is default)
ggsave("12_strips/12_strips.png", device = "png", type = "cairo", width = 8, height = 6) #Use device= and type= to stop images being pixelated  
  
