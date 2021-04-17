extrafont::loadfonts(device="win") #must be done before loading ggplot2 package

library(tidyverse)
library(readxl)
library(lubridate)

#Import sea ice data
sea_ice <- read_excel("19_global_change/Arctic Sea Ice Extent.xlsx") %>% mutate(Month = month(Date, label=TRUE)) %>% mutate(Year = year(Date)) %>% rename(Extent = `Extent (million sq km)`)

sea_ice_avg <- sea_ice %>% group_by(Month, Year) %>% mutate(avg_ext = mean(Extent)) %>% distinct(avg_ext) %>% filter(Year>1978)

#Generate plot
ggplot(sea_ice_avg, aes(x=Month, y=avg_ext, group = Year, colour = Year)) +
  geom_line() +
  scale_colour_distiller(type = "div", 
                         palette = "RdYlBu",
                         direction = -1) +
  theme_minimal() + 
  labs(x = "Month",
       y = " ",
       title = "Arctic Sea Ice Extent, 1979 to 2018",
       subtitle = "Extent (million sq km)") +
  theme(plot.title.position = "plot",
        plot.title = element_text(
          family = "Mesmerize Rg",
          size = 14,
          vjust = 1))
#Save the most recent chart as an image (inches is default)
ggsave("19_global_change/19_global_change.png", device = "png", type = "cairo", width = 8, height = 6) #Use device= and type= to stop images being pixelated
