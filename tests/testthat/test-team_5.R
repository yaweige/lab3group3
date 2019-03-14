context("test-team_5")

test_that("errors work correctly", {

  # tolerance checks
  expect_error(team_5(file = puerto_rico, tolerance = "a"))

  # file path checks
  expect_error(team_5(file = "a"))
  expect_error(team_5(file = "./data/puerto_rico.rda"))
  expect_error(team_5(file = "./data/puerto_rico.shp"))
  expect_error(team_5(file = "./data-raw/gadm36_PRI_shp/gadm36_PRI_0.cpg"))

  # sf file checks
  expect_error(team_5(file = 1))
  expect_error(team_5(file = list(1)))

})

test_that("function creates a data frame", {

  # sf file checks
  expect_equal(class(team_5(puerto_rico)), "data.frame")
  expect_equal(ncol(team_5(puerto_rico)), 5)
  expect_equal(names(team_5(puerto_rico)), c("country", "group", "order", "lat", "long"))

})
