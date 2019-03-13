#' Team 5 Function
#'
#' Function based on the work by lab group 5
#'
#' @export team_5

# library(tidyverse)

team_5 <- function(){

}

# library(sf)
#
# # A function that converts a matrix to a dataframe
# Mat2Df <- function(mat){
#
#   # Grab the longitudes and latitudes from the matrix
#   long <- mat[,1]
#   lat <- mat[,2]
#
#   # Create an order variable
#   order <- 1:nrow(mat)
#
#   # Create a group variable
#   #group <- rep(rnorm(1), nrow(mat))
#   #df <- data.frame(long = long, lat=lat,group=group,order=order)
#   df <- data.frame(long = long, lat=lat,order=order)
#   df
#
# }
#
# str(oz$geometry)
# oz_flatten <- flatten(flatten(oz$geometry))
# ozplus <- purrr::map_df(.x=oz_flatten,.f=Mat2Df, .id = "group")
# ozplus %>% ggplot(aes(x=long, y=lat, group=group)) +
#  geom_polygon()
#
