
library(tidyverse)
library(readxl)

#Import data
wta_12 <- read_excel("15_multivariate/wta_tennis_top20.xlsx") %>% drop_na()

wta_12b <- wta_12 %>% select(Player, `First_Srv_perc `:`Srv_Gm_Won_perc `)

palette(rainbow(6, s = 0.6, v = 0.75))
stars(wta_12b[, 2:7], key.loc = c(10, 1.5),
      main = "WTA Top 12 players", flip.labels = FALSE, scale = FALSE, labels = wta_12b$Player, full = FALSE, draw.segments = TRUE)
