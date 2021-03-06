extrafont::loadfonts(device="win")

library(tidyverse)
library(jpeg)
library(readxl)
library(grid)

#Import data
iss <- read_xlsx("14_space/iss_spacewalks.xlsx")


#Import image
image <- readJPEG("14_space/iss064e039894_0.jpg")
image2 <- readJPEG("14_space/iss064e039827_0.jpg")

#Generate plot
ggplot(iss, aes(x = Year, y = Spacewalks)) +
  annotation_custom(rasterGrob(image, 
                               width = unit(1,"npc"), 
                               height = unit(1,"npc")), 
                    -Inf, Inf, -Inf, Inf) +
  geom_bar(stat = "identity", alpha = 0.75, colour = "pink", fill = "pink") +
  xlab("Year") +
  ylab("Spacewalks") +
  ggtitle("International Space Station Spacewalks: 1998 to 2021") +
  labs(caption = "Data: NASA:https://www.nasa.gov/mission_pages/station/spacewalks/") +
  theme_minimal() +
  geom_text(aes(label = Spacewalks), size = 4, fontface = 2, 
            colour = 'white', hjust = 0.5, vjust = 1) +
  theme(plot.title = element_text(
    family = "Roboto",
    size = 12,
    colour = "white",
    vjust = 1
  ),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        text = element_text(colour = "white"),
        axis.text = element_text(size = rel(0.8), colour = "white"),
        plot.background = element_rect(fill = "black", color = "black")) + 
  annotate("text", x = 2016, y = 21, label = "There have been 237 spacewalks at the ISS\nsince December 1998", colour = "white")

#Save image as png
ggsave("14_space/14_space.png", device = "png", type = "cairo", width = 8, height = 6) #Use device= and type= to stop images being pixelated
