# This code creates the sf file for Puerto Rico that
# is included as an example dataset in the package

# Load libraries
library(sf)

# Create the sf file for Puerto Rico
pr_big <- read_sf("./data-raw/gadm36_PRI_shp/gadm36_PRI_0.shp")
pr_st <- maptools::thinnedSpatialPoly(as(pr_big, "Spatial"), tolerance = 0.001, minarea = 0.001, topologyPreserve = TRUE)
puerto_rico <- st_as_sf(pr_st)

# Add the puerto_rico to the data folder
#devtools::use_data(puerto_rico, overwrite = TRUE)
