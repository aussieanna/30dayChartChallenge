extrafont::loadfonts(device="win")

library(tidyverse)
library(ggridges)
library(patchwork)

#Use beavers datasets
View(beaver1)
View(beaver2)
beaver1b <- beaver1 %>% mutate(name="Beaver 1")
beaver2b <- beaver2 %>% mutate(name="Beaver 2")

#Combine datasets
beavers <- rbind(beaver1b, beaver2b)

old_theme <-
  theme(
    plot.subtitle = element_text(
      family = "Roboto",
      size = 11,
      colour = "darkslategray",
      vjust = 1
    ),
    plot.caption = element_text(
      family = "Roboto",
      colour = "darkslategray",
      size = 10,
      vjust = 1
    ),
    axis.line = element_line(
      colour = "darkgray",
      size = 0.3,
      linetype = "solid"
    ),
    panel.grid.major = element_line(colour = "gray89",
                                    size = 0.2),
    panel.grid.minor = element_line(linetype = "blank"),
    axis.title = element_text(colour = "darkslategray"),
    axis.text = element_text(family = "Roboto"),
    axis.text.x = element_text(family = "Roboto"),
    axis.text.y = element_text(family = "Roboto"),
    plot.title = element_text(family = "Roboto",
                              colour = "darkslategray"),
    legend.text = element_text(family = "Roboto"),
    legend.title = element_text(family = "Roboto"),
    panel.background = element_rect(fill = "floralwhite", colour = "floralwhite"),
    plot.background = element_rect(fill = "floralwhite", colour = "floralwhite"),
    legend.key = element_rect(fill = "floralwhite"),
    legend.background = element_rect(fill = "floralwhite")
  ) 

#Chart temperature distribution
ggplot(beavers, aes(x = temp, y = name)) + 
  geom_density_ridges(scale = 0.9, fill="lightblue") +
  labs(x = "Body temperature", 
       y = " ",
       title = "Beaver body temperature distribution",
       subtitle = "April 7 is International Beaver Day ",
       caption = "Data: P. S. Reynolds (1994) Time-series analyses of beaver body temperatures.") +
  scale_x_continuous(expand = c(0, 0)) +
  scale_y_discrete(expand = c(0, 0)) +
  coord_cartesian(clip = "off") +
  theme_minimal(base_size = 14) + 
  theme(axis.text.y = element_text(vjust = 0),
        plot.title.position = "plot") + 
  old_theme

#Chart activity distribution
ggplot(beavers, aes(x = activ, y = name)) + 
  geom_density_ridges(scale = 0.9, fill="pink") +
  labs(x = "Activity", 
       y = " ",
       title = "Beaver activity distribution",
       subtitle = "Beaver 2 was more active ",
       caption = "Data: P. S. Reynolds (1994) Time-series analyses of beaver body temperatures.") +
  scale_x_continuous(expand = c(0, 0)) +
  scale_y_discrete(expand = c(0, 0)) +
  coord_cartesian(clip = "off") +
  theme_minimal(base_size = 14) + 
  theme(axis.text.y = element_text(vjust = 0),
        plot.title.position = "plot") + 
  old_theme

ggsave("8_animals/8_animals.png", device = "png", type = "cairo", width = 8, height = 6) #Use device= and type= to stop images being pixelated
