#' Team 5
#'
#' This function was based on the work of team 7 in lab 2. From lab 2, this team convert a shp file from Austrailia to a data file.
#' Our goal is to wrap the solution from this team into a function.
#'
#' @param file This is a file path to a shape file.
#' @param tolerance is the value used for thinning the polygon. The default of this value was set as 0.1.
#'
#' @importFrom checkmate expect_class expect_file expect_logical expect_numeric expect_string
#' @importFrom maptools thinnedSpatialPoly
#' @importFrom purrr modify_depth flatten
#' @importFrom dplyr bind_row
#' @importFrom sf read_sf st_as_sf st_geometry_type
#'
#' @export team_7
#'
#'
#' @return A dataframe created from the shape file.
#'
#' @details The variables included in the dataframe that is returned from \code{team_5}
#' are as follows.
#'
#' @examples
#'
#' # A shape file for Puerto Rico is already stored in the package
#' puerto_rico
#'
#' # Use the team_7 function to convert the shape file to a dataframe
#' puerto_rico_df <- team_7(puerto_rico, 0.001)
#' head(puerto_rico_df)
#'
#' # Create a plot of Puerto Rico using the dataframe
#' library(ggplot2)
#' ggplot(puerto_rico_df, aes(x = long, y = lat, group = group)) + geom_polygon()

# Function to turn a shape file for a country into a dataframe

team_7 <- function(file, tolerance = 0.1){

  # Check function input
  checkmate::expect_numeric(tolerance)

  if (is.character(file)) {
    checkmate::expect_string(file, pattern = ".shp$",
                             info = "A file path must lead to a .shp file.")
    checkmate::expect_file(file)

    # Read shp file
    big <- sf::read_sf(file)

    # Thin big file
    thin <- maptools::thinnedSpatialPoly(as(big, "Spatial"),
                                         tolerance = tolerance,
                                         minarea = 0.001,
                                         topologyPreserve = TRUE)

    # Change thin to sf object
    shp_dat <- sf::st_as_sf(thin)

  } else {
    # Stop the function if the file is not an sf multipolygon object
    checkmate::expect_class(file[1],
                            classes = "sf",
                            info = "The file must be a multipolygon geometry created using sf")
    checkmate::expect_string(as.character(sf::st_geometry_type(file)[1]),
                             pattern = "MULTIPOLYGON",
                             info = "The file must be a multipolygon geometry created using sf")

    # Call the file shp_dat
    shp_dat <- file
  }

  # Create a dataset with a helper function, fun_7, defined down below.

  dat_7 <- shp_dat$geometry %>%
    modify_depth(3,data.frame) %>%
    # modifies elements at a given level, 3, of a nested data structure.
    modify_depth(3,fun_7) %>%
    # In this case, fun_7 is used from below to modify with depth 3.
    flatten() %>%
    flatten() %>%
    # Convert to non-nested list
    bind_rows(.id = "group")

  return(dat_7)
}

# This is the fun_7 function that create a dataframe contains longitudes, latitudes and order.
fun_7 <- function(d.frame){
  dat <- data.frame(order = c(1:nrow(d.frame)), long = d.frame$x, lat = d.frame$y)
  return(dat)
}
