
extrafont::loadfonts(device="win")
library(tidyverse)
library(rjson)
library(patchwork)
library(ggfx)

#Import data
fav_trees <- read_csv("16_trees/Forestry_Tree_Points.csv")
trees <- fromJSON(file = "16_trees/favorite-trees.json", simplify = TRUE)

trees2 <- enframe(unlist(trees))
rgx_split <- "\\."
n_cols_max <-
  trees2 %>%
  pull(name) %>% 
  str_split(rgx_split) %>% 
  map_dbl(~length(.)) %>% 
  max()
n_cols_max

nms_sep <- paste0("name", 1:n_cols_max)
data_sep <-
  trees2 %>% 
  separate(name, into = nms_sep, sep = rgx_split, fill = "right")
data_sep
trees_final <- data_sep %>% filter(name2=="treeId") %>% rename(OBJECTID = value) %>% mutate(OBJECTID=as.numeric(OBJECTID))

# Left join with fav_trees
trees_join <- left_join(trees_final, fav_trees, by = "OBJECTID")

#There are 7,384 favourite trees in New York
condition <- trees_join %>% count(TPCondition, sort = TRUE) %>% drop_na()
species <- trees_join %>% count(GenusSpecies, sort = TRUE) %>% slice(c(1:10))

#Make bar charts
p1 <- ggplot(condition, aes(x=reorder(TPCondition, n), y=n)) +
  with_shadow(geom_bar(stat="identity", fill = "purple", alpha = 0.75), sigma = 4) +
  coord_flip() + 
  labs(y = "Number",
       x = "Condition") +
  theme_minimal() + 
  ggtitle('Most Favourite Trees in Good Condition') +
  theme(plot.title.position = "plot")
p1

p2 <- ggplot(species, aes(x=reorder(GenusSpecies, n), y=n)) +
  with_shadow(geom_bar(stat="identity", fill = "yellow", alpha = 0.75), sigma = 4) +
  coord_flip() + 
  labs(y = "Number",
       x = "Genus/Species") +
  theme_minimal() + 
  ggtitle('Top 10 Favourite Trees in New York City') +
  theme(plot.title.position = "plot")
p2

p2 + p1

#Save the most recent chart as an image (inches is default)
ggsave("16_trees/16_trees.png", device = "png", type = "cairo", width = 10, height = 6) #Use device= and type= to stop images being pixelated
