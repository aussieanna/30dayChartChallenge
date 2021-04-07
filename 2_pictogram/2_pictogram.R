extrafont::loadfonts(device="win")

library(palmerpenguins)
library(waffle)
library(extrafont)
library(ggplot2)

species <- penguins_raw %>% count(Species)

waffle(species$n, rows = 10, use_glyph = "car", glyph_size = 3) + expand_limits(y = c(0, 4))

#Import data
library(tidyverse)
library(readxl)
isotype_1937 <- read_excel("2_pictogram/isotype_1937.xlsx")

ggplot(isotype_1937, aes(fill=Thing, values=Number)) +
  geom_waffle(color="white", size = .25, n_rows = 10) +
  facet_wrap(~Country, ncol= 1, strip.position = "left") +
  scale_x_discrete() +
  coord_flip()

#Example
library(dplyr)
library(waffle)

storms %>% 
  filter(year >= 2010) %>% 
  count(year, status) -> storms_df
ggplot(storms_df, aes(fill = status, values = n)) +
  geom_waffle(color = "white", size = .25, n_rows = 10, flip = TRUE) +
  facet_wrap(~year, nrow = 1, strip.position = "bottom") +
  scale_x_discrete() + 
  scale_y_continuous(labels = function(x) x * 10, # make this multiplyer the same as n_rows
                     expand = c(0,0)) +
  ggthemes::scale_fill_tableau(name=NULL) +
  coord_equal() +
  labs(
    title = "Faceted Waffle Bar Chart",
    subtitle = "{dplyr} storms data",
    x = "Year",
    y = "Count"
  ) +
  theme_minimal(base_family = "Roboto Condensed") +
  theme(panel.grid = element_blank(), axis.ticks.y = element_line()) +
  guides(fill = guide_legend(reverse = TRUE))

data.frame(
  parts = factor(rep(month.abb[1:3], 3), levels=month.abb[1:3]),
  vals = c(10, 20, 30, 6, 14, 40, 30, 20, 10),
  col = rep(c("blue", "black", "red"), 3),
  fct = c(rep("Thing 1", 3),
          rep("Thing 2", 3),
          rep("Thing 3", 3))
) -> xdf

xdf %>%
  count(parts, wt = vals) %>%
  ggplot(aes(label = parts, values = n)) +
  geom_pictogram(n_rows = 10, aes(colour = parts), flip = TRUE, make_proportional = TRUE) +
  scale_color_manual(
    name = NULL,
    values = c("#a40000", "#c68958", "#ae6056"),
    labels = c("Fruit", "Sammich", "Pizza")
  ) +
  scale_label_pictogram(
    name = NULL,
    values = c("apple-alt", "bread-slice", "pizza-slice"),
    labels = c("Fruit", "Sammich", "Pizza")
  ) +
  coord_equal() +
  #theme_ipsum_rc(grid="") +
  theme_enhance_waffle() +
  theme(legend.key.height = unit(2.25, "line")) +
  theme(legend.text = element_text(size = 10, hjust = 0, vjust = 0.75))

ggplot (mtcars)  +  
  geom_text( aes ( mpg , wt , colour = factor ( cyl )), 
             label =  "\uf1b9" , 
             family =  "FontAwesome" , 
             size =  7)

#Electric vehicle sales data
cars <- read_excel("2_pictogram/ev_volumes.xlsx")
ggplot (cars)  +  
  geom_text( aes ( Year , PEV_share), 
             label =  "\uf1b9" , 
             family =  "FontAwesome" , 
             size =  7) +
  geom_text( aes ( Year , PEV_share), 
             label =  "\uf0e7" , 
             family =  "FontAwesome" , 
             size = 4,
             colour = "light blue") +
  theme_minimal() +
  labs(y = "Percent",
       title = "Global Plug In Electric Vehicle Market Share",
       subtitle = "Global Plug-in Vehicle Sales Reached over 3.2 Million in 2020",
       caption = "Data:https://www.ev-volumes.com/") +
  theme(plot.title.position = "plot")

ggsave("2_pictogram/2_pictogram.png", device = "png", type = "cairo", width = 8, height = 6) #Use device= and type= to stop images being pixelated
