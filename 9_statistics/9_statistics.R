
library(tidyverse)
library(readxl)
library(ggstream)

#Import data
house <- read_excel("9_statistics/med_hse_pr_state.xlsx")
house_long <- pivot_longer(house, NSW:Tas) %>% rename(State=name) %>% rename(Median=value)

label <- house_long %>% group_by(State) %>% mutate(max = max(Median)) %>% distinct(max)

#Graph data
ggplot(house_long, aes(x=Date, y=Median, fill=State)) + geom_area() +
  theme_minimal()

# The palette with grey:
cbPalette <- c("#999999", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")

#Streamplot
ggplot(house_long, aes(Date, Median, fill = State)) +
  geom_stream(bw = 0.5, type = "ridge",alpha=0.75) +
  #geom_text(label) +
  theme_minimal() +
  #geom_stream_label(aes(label = State)) + 
  scale_fill_manual(values = cbPalette) + 
  theme (legend.position = "none") + 
  coord_cartesian(expand = c(0)) +
  labs(title = "Median house prices ('000s), Australia")

                    