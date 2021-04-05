library(tidyverse)
library(scales)

conjugal <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-02-16/conjugal.csv')

#extrafont::font_import()
#extrafont::loadfonts(device="win")

red <- '#E22B4C'
yellow <- '#F9B600'
green <- '#4B6C5A'

colours <- c('#4B6C5A', '#F9B600','#E22B4C')

#Pivot data from wide to long
conjugal_long <- conjugal %>% pivot_longer(cols=Single:`Divorced and Widowed`, names_to = "Status", values_to = "Percent")

#Graph data
ggplot(data=conjugal_long, aes(x=Population, y=Percent, fill=Status, label = Percent)) + 
  geom_bar(stat="identity") + 
  scale_fill_manual(values=colours) + 
  facet_grid(Age ~ ., switch="both") + 
  theme_minimal() + 
  coord_flip() + 
  guides(fill=guide_legend(reverse=TRUE, title = NULL)) + labs(x=" ", y="Per cent ") + 
  theme(legend.position="top") +
  ggtitle("CONJUGAL CONDITION") +
  theme(plot.title=element_text(family="Trebuchet MS", face="bold", size=20)) + 
  geom_text(position=position_stack(vjust = 0.5)) + theme(plot.background = element_rect(fill = "antique white", color = "antique white"))

ggsave("3_historical/3_historical.png", device = "png", type = "cairo", width = 8, height = 6) #Use device= and type= to stop images being pixelated
