---
title: "Lab 3 - Group 3 Submission"
author: "Yawei Ge, Katherine Goode, and Earl Hur"
date: "3/13/2019"
output: 
  html_document:
    keep_md: TRUE
---



# Overview <img align="right" width="225" height="225" src="./data-raw/sticker.png">

The package lab3group3 was created for a lab in STAT 585 at ISU. It contains three functions that convert sf country shape files into data frames. The  These functions are all based on solutions from lab 2 created by other lab groups in the class. All three functions should produce the same output, but they use different techniques to change the sf object to a dataframe.

Here is a link to our GitHub [repository](https://github.com/yaweige/lab3group3) where the code for the package is stored.

# Installation

The package can be downloaded from GitHub. You can use the following code to install `lab3group3`.


```r
# Install the package from github
devtools::install_github("yaweige/lab3group3")
```

# Example Data

To demonstrate the functionality of the functions in lab3group3, we will use the 


```r
library(tidyverse)
library(purrr)
library(sf)
ozbig <- read_sf("./data/gadm36_AUS_shp/gadm36_AUS_1.shp")
oz_st <- maptools::thinnedSpatialPoly(as(ozbig, "Spatial"), tolerance = 0.1, minarea = 0.001, topologyPreserve = TRUE)
oz <- st_as_sf(oz_st)
```

# Functions

### `team_5`
