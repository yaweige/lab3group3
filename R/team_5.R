#' Team 5 Function
#'
#' Function based on the work by lab group 5 that converts a country shape file into a dataframe.
#'
#' @param file This is the shape file that will be converted to a datafarme. It can either
#'   be a file path in the form of a character string (ends in .shp) or a sf shape file
#'   object created using the sf package with a geometry type of multipolygon.
#' @param tolerance This controls how much the shape file is thinned. The larger it is made
#'   the less detail the shape file will have. The tolerance is set to 0.1 by default.
#'
#' @importFrom checkmate expect_class expect_file expect_logical expect_numeric expect_string
#' @importFrom dplyr %>% mutate select
#' @importFrom maptools thinnedSpatialPoly
#' @importFrom methods as
#' @importFrom purrr flatten map_df
#' @importFrom rlang .data
#' @importFrom sf read_sf st_as_sf st_geometry_type
#'
#' @export team_5
#'
#' @return A dataframe created from the shape file. See the details for the
#'   variables included in the dataframe.
#'
#' @details The variables included in the dataframe that is returned from \code{team_5}
#' are as follows.
#' \itemize{
#' \item country = country depicted by the data
#' \item group = indicates which polygon a set of points corresponds to
#' \item order = order in which the points in a polygon should be arranged
#' \item long = longitude of the point
#' \item lat = latitude of the point
#' }
#' @examples
#'
#' # A shape file for Puerto Rico is already stored in the package
#' puerto_rico
#'
#' # Use the team_5 function to convert the shape file to a dataframe
#' puerto_rico_df <- team_5(puerto_rico, 0.001)
#' head(puerto_rico_df)
#'
#' # Create a plot of Puerto Rico using the dataframe
#' library(ggplot2)
#' ggplot(puerto_rico_df, aes(x = long, y = lat, group = group)) + geom_polygon()

# Function to turn a shape file for a country into a dataframe
team_5 <- function(file, tolerance = 0.1){

  # Check to make sure that the tolerance is a single numeric value
  checkmate::expect_numeric(tolerance)

  # Determine whether the file is file path or a shape file and
  # prepare it accordingly to be turned into a dataframe
  if (is.character(file)) {

    # Stop the function if a character string was input but does end with .shp
    checkmate::expect_string(file, pattern = ".shp$",
                             info = "A file path must lead to a .shp file.")

    # Stop the function if the file cannot be found
    checkmate::expect_file(file)

    # Read in the shape file
    big <- sf::read_sf(file)

    # Thin the shape file
    thinned <- maptools::thinnedSpatialPoly(as(big, "Spatial"),
                                            tolerance = tolerance,
                                            minarea = 0.001,
                                            topologyPreserve = TRUE)

    # Change the file to an sf object
    shape_data <- sf::st_as_sf(thinned)

  } else if (is.list(file)){

    # Stop the function if the file is a list but is not an sf multipolygon object
    checkmate::expect_class(file[1],
                            classes = "sf",
                            info = "The file must be a multipolygon geometry created using sf")
    checkmate::expect_string(as.character(sf::st_geometry_type(file)[1]),
                             pattern = "MULTIPOLYGON",
                             info = "The file must be a multipolygon geometry created using sf")


    # Call the file shape data
    shape_data <- file

  } else {

    # Stop the function if the input file is not a file path or a list
    stop("The file must be either a file path to a .shp file or an sf multipolygon object created using the sf package.")

  }

  # Convert the nested lists into a non-nested list
  flattened <- flatten(flatten(shape_data$geometry))

  # Join the lists into a dataframe and create a group variable
  final_df <- map_df(.x = flattened,
                     .f = mat2df, # this is a helper function found below
                     .id = "group") %>%
    mutate(country = shape_data$NAME_0[1]) %>%
    select(.data$country, .data$group, .data$order, .data$lat, .data$long)
    # for .data solution see the answer by loudermilk on https://github.com/STAT545-UBC/Discussion/issues/451
    # also see this page https://dplyr.tidyverse.org/articles/programming.html

  # Return the dataframe
  return(final_df)

}

# A function that converts a matrix to a dataframe which gets used by team_5
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

