library(testthat)

source(file.path(here::here(), "src", "custom.R"))

test_that("listCsvs() validates input", {
  
  myMsg <- " is not of class 'character'"
  
  expect_error(listCsvInDir(), 
               "argument \"dir\" is missing, with no default")
  expect_error(listCsvInDir(8), myMsg)
  expect_error(listCsvInDir(FALSE), myMsg)
  expect_error(listCsvInDir(matrix(letters)), myMsg)
  expect_error(listCsvInDir(data.frame(letters)), myMsg)
})


test_that("listCsvs returns a character vector of file paths", {
 
  # Prep
  test_data <- "test_data"
  dir.create(test_data)
  
  for (i in seq_len(n <- 10L)) {
    d <- data.frame(x = runif(n), y = runif(n), z = runif(n))
    path <- tempfile(tmpdir = test_data, fileext = ".csv")
    write.csv(d, path)
  }
  
  # Tests
  result <- listCsvInDir(test_data)
  
  expect_length(listCsvInDir("fake"), 0)
  expect_is(result, "character")
  expect_type(result, "character")
  expect_length(result, n)
  expect_match(result, "\\.csv$")
  
  unlink(test_data, recursive = TRUE)
})
