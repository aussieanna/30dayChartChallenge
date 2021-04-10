
library(tidyverse)
library(scales) #scale functions for graphs
library(lubridate) #Dates and times made easy

#Import Canberra weather data
cbr_2020 <- read_csv("11_circular/asos_cbr_2020.csv")

#Extract date from datetime using substring function (extracts variables as character)
cbr_2020$valid2 <- substr(cbr_2020$valid, 1,10) #day, month, year

maxtmp <- cbr_2020 %>% group_by(valid2) %>%
  summarise(max=max(tmpc))
mintmp <- cbr_2020 %>% group_by(valid2) %>%
  summarise(min=min(tmpc))
meantmp <- cbr_2020 %>% group_by(valid2) %>%
  summarise(mean=mean(tmpc))

tmp_data <- merge(maxtmp, mintmp, c("valid2"))
tmp_data2 <- merge(tmp_data, meantmp, c("valid2"))
cbr_2020_2 <- merge(cbr_2020, tmp_data2, c("valid2")) %>% distinct(valid2, min, max, mean) %>%
  mutate(valid2 = as.Date(valid2))

cbr_plot <- ggplot(cbr_2020_2, aes(valid2,
                            ymin = min,
                            ymax = max,
                            color = mean)) +
  geom_linerange(size = 1.3, alpha = 0.75) +
  scale_color_viridis_c(NULL, option = "plasma") +
  coord_polar() + 
  theme_minimal() +
  theme(legend.position = "right") +
  scale_x_date(labels = date_format("%b"), breaks = date_breaks("month")) +
  labs(title = "Canberra Weather",
       subtitle = "Mean temperature, 1 Jan to 31 Dec 2020",
       caption = "Data: Australian Bureau of Meterology ",
       x = NULL, y = NULL) + 
  scale_y_continuous(breaks=NULL) +
  expand_limits(y=0) 

cbr_plot

#Save the most recent chart as an image (inches is default)
ggsave("11_circular/11_circular.png", device = "png", type = "cairo", width = 6, height = 6) #Use device= and type= to stop images being pixelated
