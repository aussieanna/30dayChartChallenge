
library(tidyverse)
library(readxl)
library(ggstream)

#Import data
house <- read_excel("9_statistics/med_hse_pr_state.xlsx")
house_long <- pivot_longer(house, NSW:Tas) %>% rename(State=name) %>% rename(Median=value)

max_median <- house_long %>% group_by(State) %>% filter(Median==max(Median))

#Graph data
ggplot(house_long, aes(x=Date, y=Median, fill=State)) + geom_area() +
  theme_minimal()

#Streamplot
ggplot(house_long, aes(Date, Median, fill = State, label=State)) +
  geom_stream(bw = 0.5, type = "mirror",alpha=0.75) +
  #geom_text(data = max_median, aes(label=State)) +
  theme_minimal() +
  geom_stream_label(size=4) + 
  scale_fill_viridis_d() + 
  theme (legend.position = "none") + 
  coord_cartesian(expand = c(0)) +
  labs(title = "Median house prices ('000s), Australia",
       subtitle = "Median prices have increased in all jurisdictions over time",
       y = " ",
       caption = "Data: ABS 6416.0 Residential Property Price Indexes") +
  theme(plot.title.position = "plot")

#Save the most recent chart as an image (inches is default)
ggsave("9_statistics/9_statistics.png", device = "png", type = "cairo", width = 8, height = 6) #Use device= and type= to stop images being pixelated                  
