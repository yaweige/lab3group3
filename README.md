Lab 3 - Group 3 Submission
================
Yawei Ge, Katherine Goode, and Earl Hur
3/24/2019

Overview <img align="right" width="225" height="225" src="./data-raw/sticker.png">
==================================================================================

The package lab3group3 was created for a lab in STAT 585 at ISU. It contains three functions that convert sf country shape files into data frames. These functions are all based on solutions from lab 2 created by other lab groups in the class. All three functions should produce the same output, but they use different techniques to change the sf object to a dataframe.

Here is a link to our GitHub [repository](https://github.com/yaweige/lab3group3) where the code for the package is stored.

Installation
============

The package can be downloaded from GitHub. You can use the following code to install.

``` r
# Install the package from github
devtools::install_github("yaweige/lab3group3")
```

You can then load the package in the normal way.

``` r
# Load the package
library(lab3group3)
```

Example Data
============

To demonstrate the functionality of the functions in lab3group3, we will use the Australia shape file downloaded from [gdam](https://gadm.org/download_country_v3.html). The code below loads in the .shp file, thins the data, and converts it into a sf object.

``` r
# Load packages that will be used
library(sf)
library(tidyverse)

# Read in the large Austrailia shape file
ozbig <- read_sf("./data/gadm36_AUS_shp/gadm36_AUS_1.shp")

# Thin the file
oz_st <- maptools::thinnedSpatialPoly(as(ozbig, "Spatial"), 
                                      tolerance = 0.1, 
                                      minarea = 0.001, 
                                      topologyPreserve = TRUE)

# Convert it to a sf file
oz <- st_as_sf(oz_st)
```

Functions
=========

### `team_1`

The `team_1` function was written by Yawei. It was created based on the solution for lab2 by group 1.

The function has two input values.

-   `file`: This is the shape file that will be converted to a dataframe. It can either be a file path in the form of a character string (ends in .shp) or a sf shape file object created using the sf package with a geometry type of multipolygon.
-   `tolerance`: This controls how much the shape file is thinned. The larger it is made the less detail the shape file will have. The tolerance is set to 0.1 by default.

The function returns a dataframe with the following variables.

-   `listno`: The orginal rows that the expanded data coming from
-   `group`: indicates which polygon a set of points corresponds to
-   `order`: order in which the points in a polygon should be arranged
-   `long`: longitude of the point
-   `lat`: latitude of the point
-   `other variables`: other variables in the original data will be kept

``` r
# Use the team_5 function to convert the shape file to a dataframe
oz_df_1 <- team_1(oz, 0.1)

# Print the head of the dataframe
head(oz_df_1)
```

    ##   listno GID_0    NAME_0   GID_1                      NAME_1 VARNAME_1
    ## 1      1   AUS Australia AUS.1_1 Ashmore and Cartier Islands      <NA>
    ## 2      1   AUS Australia AUS.1_1 Ashmore and Cartier Islands      <NA>
    ## 3      1   AUS Australia AUS.1_1 Ashmore and Cartier Islands      <NA>
    ## 4      1   AUS Australia AUS.1_1 Ashmore and Cartier Islands      <NA>
    ## 5      1   AUS Australia AUS.1_1 Ashmore and Cartier Islands      <NA>
    ## 6      1   AUS Australia AUS.1_1 Ashmore and Cartier Islands      <NA>
    ##   NL_NAME_1    TYPE_1 ENGTYPE_1 CC_1 HASC_1 group order     long       lat
    ## 1      <NA> Territory Territory   12  AU.AS     1     1 123.5556 -12.53057
    ## 2      <NA> Territory Territory   12  AU.AS     1     2 123.5554 -12.53213
    ## 3      <NA> Territory Territory   12  AU.AS     1     3 123.5524 -12.53137
    ## 4      <NA> Territory Territory   12  AU.AS     1     4 123.5536 -12.53039
    ## 5      <NA> Territory Territory   12  AU.AS     1     5 123.5556 -12.53057
    ## 6      <NA> Territory Territory   12  AU.AS     2     1 123.0178 -12.25917

``` r
# Create a plot of Austrailia using the dataframe
ggplot(oz_df_1, aes(x = long, y = lat, group = group)) + 
  geom_polygon()
```

![](README_files/figure-markdown_github/unnamed-chunk-4-1.png)

### `team_5`

The `team_5` function was written by Katherine. It was created using code based on the solution for lab 2 by lab group 5.

The function has two input values.

-   `file`: This is the shape file that will be converted to a dataframe. It can either be a file path in the form of a character string (ends in .shp) or a sf shape file object created using the sf package with a geometry type of multipolygon.
-   `tolerance`: This controls how much the shape file is thinned. The larger it is made the less detail the shape file will have. The tolerance is set to 0.1 by default.

The function returns a dataframe with the following variables.

-   `country`: country depicted by the data
-   `group`: indicates which polygon a set of points corresponds to
-   `order`: order in which the points in a polygon should be arranged
-   `long`: longitude of the point
-   `lat`: latitude of the point

Here is an example using the function `team_5` with the Australia data.

``` r
# Use the team_5 function to convert the shape file to a dataframe
oz_df_5 <- team_5(oz, 0.1)

# Print the head of the dataframe
head(oz_df_5)
```

    ##     country group order       lat     long
    ## 1 Australia     1     1 -12.53057 123.5556
    ## 2 Australia     1     2 -12.53213 123.5554
    ## 3 Australia     1     3 -12.53137 123.5524
    ## 4 Australia     1     4 -12.53039 123.5536
    ## 5 Australia     1     5 -12.53057 123.5556
    ## 6 Australia     2     1 -12.25917 123.0178

``` r
# Create a plot of Austrailia using the dataframe
ggplot(oz_df_5, aes(x = long, y = lat, group = group)) + 
  geom_polygon()
```

![](README_files/figure-markdown_github/unnamed-chunk-5-1.png)

### `team_7`

The `team_7` function was written by Earl.

This function was based on the work of team 7 in Lab 2.

From Lab 2, the team converted a shp file of Austrailia to a data frame. Our goal is to wrap this solution into a function.

``` r
# Use the team_7 function to convert the shape file to a dataframe
oz_df_7 <- team_7(oz, 0.1)

# Print the head of the dataframe
head(oz_df_7)
```

    ##   group order     long       lat
    ## 1     1     1 123.5556 -12.53057
    ## 2     1     2 123.5554 -12.53213
    ## 3     1     3 123.5524 -12.53137
    ## 4     1     4 123.5536 -12.53039
    ## 5     1     5 123.5556 -12.53057
    ## 6     2     1 123.0178 -12.25917

``` r
# Create a plot of Austrailia using the dataframe
ggplot(oz_df_7, aes(x = long, y = lat, group = group)) + 
  geom_polygon()
```

![](README_files/figure-markdown_github/unnamed-chunk-6-1.png)
