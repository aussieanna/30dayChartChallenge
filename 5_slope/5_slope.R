
library(tidyverse)
library(CGPfunctions)

slope <- read_csv("5_slope/2018-australiansdg-indicator-3-4-1-table1.csv") 

slope_long <- pivot_longer(slope, `2015`:`2019`) %>% rename(Year=name, Rate=value) %>% filter(Year %in% c("2015", "2019"))


#Make slope chart
newggslopegraph(dataframe = slope_long,
                Times = Year,
                Measurement = Rate,
                Grouping = Disease,
                Title = "Standardised Death Rates, Australia",
                SubTitle = "Rate per 100,000 population. 2015 vs 2019",
                Caption = "Data source: data.gov.au",
                LineThickness = .5,
                YTextSize = 4,
                LineColor = c(rep("gray",1), "blue", rep("gray",2), "blue", rep("gray",10))
)

#Save the most recent chart as an image (inches is default)
ggsave("5_slope/5_slope.png", device = "png", type = "cairo", width = 8, height = 6) #Use device= and type= to stop images being pixelated
