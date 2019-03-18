#' Impletement the Team 1 Solution in Lab 2
#'
#' This function need a file path as an input to read the .shp file, and it will
#' extract the geometry information to the top level.
#' @param file A path to the .shp file. Or a loaded sf shape file created using sf
#' package with a geometry type of mutipolygon. If a loaded sf shape is supplied, the
#' the tolerance is turned off.
#' @param tolerance The value used to thin the data.
#' @export
#' @return A data.frame with the geometry information extracted to the top level.
#' All other columns are kept. The new columns are as follows:
#'
#' \tabular{ll}{
#'  listno\tab The orginal rows that the expanded data coming from.\cr
#'  long\tab Longitude. \cr
#'  lat\tab Latitude. \cr
#'  group\tab The group used to draw polygen. \cr
#'  order\tab The order for the points within group. }
#' @importFrom sf read_sf st_as_sf st_geometry_type
#' @importFrom maptools thinnedSpatialPoly
#' @importFrom checkmate expect_numeric expect_file expect_string expect_class
#' @import dplyr
#' @import purrr
#' @import tibble
#' @examples
#'
#' # A shape file for Puerto Rico is already stored in the package
#' puerto_rico
#'
#' # Use the team_1 function to convert the shape file to a dataframe
#' puerto_rico_df <- team_1(puerto_rico)
#' head(puerto_rico_df)
#'
#' # Create a plot of Puerto Rico using the dataframe
#' library(ggplot2)
#' ggplot(puerto_rico_df, aes(x = long, y = lat, group = group)) + geom_polygon()



team_1 <- function(file, tolerance = 0.1) {
  # check the input
  checkmate::expect_numeric(tolerance)

  if (is.character(file)) {
    checkmate::expect_file(file)
    checkmate::expect_string(file, pattern = ".shp$",
                             info = "A file path must lead to a .shp file.")

    # read data and thin the data
    ozbig <- sf::read_sf(file)
    oz_st <- maptools::thinnedSpatialPoly(as(ozbig, "Spatial"),
                                          tolerance = tolerance,
                                          minarea = 0.001,
                                          topologyPreserve = TRUE)
    oz <- sf::st_as_sf(oz_st)
  } else {
    # Stop the function if the file is not an sf multipolygon object
    checkmate::expect_class(file[1],
                            classes = "sf",
                            info = "The file must be a multipolygon geometry created using sf")
    checkmate::expect_string(as.character(sf::st_geometry_type(file)[1]),
                             pattern = "MULTIPOLYGON",
                             info = "The file must be a multipolygon geometry created using sf")


    # Call the file shape data
    oz <- file
  }

  # keep the list number to bind the original information except geomtry
  listno <- oz$geometry %>%
    purrr::map_depth(3, data.frame) %>%
    purrr::map_depth(3, tibble::rowid_to_column) %>%
    purrr::map_depth(1, purrr::flatten) %>%
    purrr::map_depth(1, dplyr::bind_rows) %>%
    dplyr::bind_rows(.id = "listno") %>%
    dplyr::select(listno) %>%
    dplyr::mutate(listno = as.integer(listno))

  # reorganize the data
  df.oz.purr <- oz$geometry %>%
    purrr::map_depth(3, data.frame) %>%
    purrr::map_depth(3, tibble::rowid_to_column) %>%
    purrr::flatten() %>%
    purrr::flatten() %>%
    dplyr::bind_rows(.id = "group") %>%
    dplyr::rename("lat" = y, "long" = x, "order" = rowid) %>%
    dplyr::bind_cols(listno)

  # bind to a new data with original columns
  df.oz.purr <- oz %>%
    as.data.frame() %>%
    dplyr::select(-geometry) %>%
    tibble::rowid_to_column() %>%
    dplyr::left_join(df.oz.purr, by = c("rowid" = "listno")) %>%
    dplyr::rename("listno" = rowid)

  return(df.oz.purr)
}

