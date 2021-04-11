
#Import fonts - only needs to be done once per R session?
extrafont::font_import()
extrafont::loadfonts(device="win") #must be done before loading ggplot2 package

library(tidyverse)
library(gt)
library(patchwork)

df1 <- anscombe %>% select(x1,y1) %>% mutate(name="Dataset 1") %>% rename(x=x1, y=y1)
df2 <- anscombe %>% select(x2,y2) %>% mutate(name="Dataset 2") %>% rename(x=x2, y=y2)
df3 <- anscombe %>% select(x3,y3) %>% mutate(name="Dataset 3") %>% rename(x=x3, y=y3)
df4 <- anscombe %>% select(x4,y4) %>% mutate(name="Dataset 4") %>% rename(x=x4, y=y4)

#Combine data sets
df_all <- rbind(df1, df2, df3, df4)

data_sum <- df_all %>% group_by(name) %>%
  summarise(
    n = n(),
    mean_x = mean(x),
    sd_x = sd(x),
    median_x = median(x),
    mean_y = mean(y),
    sd_y = sd(y),
    median_y = median(y)
  )
# Make a table of statistics
t <- data_sum %>% gt_preview()

#Chart data sets
p <- ggplot(df_all, aes(x=x, y=y, colour=name))+
  geom_point()+
  theme_void(base_family = "Inria Sans")+
  theme(legend.position = "none")+
  facet_wrap(~name, ncol=2) + 
  scale_colour_viridis_d() +                                      # Add regression line
  geom_smooth(method = "lm",
              formula = y ~ x) + 
  ggtitle("Anscombe's Quartet") +
  labs(subtitle = " ")

#Combine Table and Chart
p / gridExtra::tableGrob(df_all %>% group_by(name) %>%
                           summarise(
                             n = n(),
                             mean_x = mean(x),
                             sd_x = sd(x),
                             median_x = median(x),
                             mean_y = mean(y),
                             sd_y = sd(y),
                             median_y = median(y)
                           ))

ggsave("13_correlation/13_correlation.png", device = "png", type = "cairo", width = 8, height = 6) #Use device= and type= to stop images being pixelated
