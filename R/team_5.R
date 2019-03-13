#' Team 5 Function
#'
#' Function based on the work by lab group 5
#'
#' @importFrom purrr flatten map_df
#' @importFrom sf read_sf st_as_sf
#' @importFrom maptools thinnedSpatialPoly
#' @export team_5

# ozplus %>% ggplot(aes(x=long, y=lat, group=group)) +
#  geom_polygon()


# team_5("../data/gadm36_PRI_shp/gadm36_PRI_0.shp", 0.001)
# team_5(puerto_rico, 0.001)
# team_5(puerto_rico, 0.001) %>%
#   ggplot(aes(x = long, y = lat, group = group)) +
#   geom_polygon()

team_5 <- function(file, tolerance){

  if (is.character(file)){

    # Read in the shape file
    big <- sf::read_sf(file)

    # Thin the shape file
    thinned <- maptools::thinnedSpatialPoly(as(big, "Spatial"),
                                            tolerance = tolerance,
                                            minarea = 0.001,
                                            topologyPreserve = TRUE)

    # Change the file to an sf object
    shape_data <- sf::st_as_sf(thinned)

  } else {

    # Call the file shape data
    shape_data <- file

  }

  # Convert the nested lists into a non-nested list
  flattened <- flatten(flatten(shape_data$geometry))

  # Join the lists into a dataframe and create a group variable
  final_df <- map_df(.x = flattened, .f = mat2df, .id = "group")

  # Return the dataframe
  return(final_df)

}

# A function that converts a matrix to a dataframe
mat2df <- function(mat){

  # Grab the longitudes and latitudes from the matrix
  long <- mat[,1]
  lat <- mat[,2]

  # Create an order variable
  order <- 1:nrow(mat)

  # Create a group variable...this was a mistake, so I chose to exclude
  # it and add a group variable later
  # group <- rep(rnorm(1), nrow(mat))

  # Create a dataframe...the first line was the old version of the code and
  # the second line is my version
  # df <- data.frame(long = long, lat=lat,group=group,order=order)
  df <- data.frame(long = long, lat = lat, order = order)

  # Return the dataframe
  df

}

