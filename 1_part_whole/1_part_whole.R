
library(tidyverse)
library(readxl)
library(paletteer)
library(ggfittext)
library(ggtext)
#Import_data
dth_data <- read_excel("1_part_whole/2020_prov_aus_deaths.xlsx", 
                       sheet = "Sheet2") %>% filter(Disease!="Total") %>% mutate(group="All") %>% arrange(desc(Percent))
head(dth_data)

# The palette with grey:
cbPalette <- c("#999999", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")

#Graph data
ggplot(data=dth_data, aes(x=group, y=Percent, label = round(Percent,1), fill=Disease)) + 
  geom_bar(stat="identity") + 
  scale_fill_manual(values=cbPalette) + 
  theme_void() +
  theme(plot.subtitle = element_markdown(size = 11, lineheight = 1.2)) +
  coord_flip() + 
  guides(fill=guide_legend(reverse=TRUE, title = NULL)) + 
  labs(x=" ", y=" ", subtitle = "<span style = 'color:#999999;'>Cancer</span> was responsible for 34% of deaths while <span style = 'color:#56B4E9;'>COVID-19</span> only 0.5% of deaths<br>", caption = "Data source: ABS Provisional Mortality Statistics") + 
  theme(legend.position="top") +
  ggtitle("Provisional 2020 Deaths, Australia") +
  theme(plot.title=element_text(family="Trebuchet MS", face="bold", size=20)) + geom_bar_text(position = "stack", reflow = TRUE)

#Save chart
ggsave("1_part_whole/aus_dths_2020.png", device = "png", type = "cairo", width = 8, height = 6) #Use device= and type= to stop images being pixelated  
