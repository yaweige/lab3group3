context("test-team_1")

test_that("Successfully detect the input type", {
  #test for the file path
  expect_error(team_1("abc"))
  expect_error(team_1(1:3))
  #test for sp data with geometry
  expect_error(team_1(as.data.frame(puerto_rico)))
  #test for tolerance
  expect_error(team_1(puerto_rico, tolerance = "a"))
})


test_that("correct output type", {
  #test for class of the output
  expect_equal(class(team_1(puerto_rico)), "data.frame")
  #test for expected variables
  expect_equal(names(team_1(puerto_rico)), c("listno", names(puerto_rico)[1:2],
                                      "group", "order", "long", "lat"))
})
