
extrafont::loadfonts(device="win")
library(tidyverse)
library(gcookbook)
library(igraph)
library(arcdiagram)

madmen

m <- madmen[1:nrow(madmen) %% 2 == 1, ]
g <- graph.data.frame(m, directed=FALSE)

plot(g)

op = par(mar = c(0.5, 5, 0.5, 3))
par(op)

par(mar = c(10,1,1,1))
madmen.edges <- get.edgelist(g)
arcplot(madmen.edges, show.nodes = TRUE, show.labels = TRUE,
        lwd.arcs=4*runif(10,.5,2), col.arcs=hsv(runif(9,0.5,0.9),alpha=0.4),
        col.nodes = "grey", main = "Relationships in Mad Men",
        col.main = "navy")

m2 <- madmen
g2 <- graph.data.frame(m2, directed=FALSE)

plot(g2)
madmen.edges2 <- get.edgelist(g2)
arcplot(madmen.edges2, show.nodes = TRUE, show.labels = TRUE,
        lwd.arcs=4*runif(10,.5,2), col.arcs=hsv(runif(9,0.5,0.9),alpha=0.4),
        col.nodes = "grey", main = "Relationships in Mad Men",
        col.main = "navy")
