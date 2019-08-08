# Custom functions

listCsvInDir <- function(dir) {
  if (!inherits(dir, "character"))
    stop(deparse(substitute(dir)), " is not of class 'character'")
  list.files(dir, "\\.csv$", full.names = TRUE, ignore.case = TRUE)
}