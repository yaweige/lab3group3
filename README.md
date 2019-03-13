---
title: "Lab 3 - Group 3 Submission"
author: "Katherine Goode"
date: "3/13/2019"
output: 
  html_document:
    keep_md: TRUE
---



Here is a link to our [repository](https://github.com/yaweige/lab3group3).


```r
library(tidyverse)
library(purrr)
library(sf)
ozbig <- read_sf("./data/gadm36_AUS_shp/gadm36_AUS_1.shp")
oz_st <- maptools::thinnedSpatialPoly(as(ozbig, "Spatial"), tolerance = 0.1, minarea = 0.001, topologyPreserve = TRUE)
oz <- st_as_sf(oz_st)
```

