# Create data tables

library(RSQLite)
library(here)

source(file.path(here(), "src", "custom.R"))

dataDir <- file.path(here(), "data")
if(!dir.exists(dataDir))
  dir.create(dataDir)

csvFiles <- if (interactive()) {
  listCsvInDir(dataDir)
} else {
  commandArgs(trailingOnly = TRUE)
}

filenames <- basename(csvFiles)
tableNames <-
  substr(filenames, 1, regexpr("\\.csv$", filenames) - 1)

purrr::map2(csvFiles, tableNames, function(f, t) {
  df <- read.csv(f, stringsAsFactors = TRUE)
  try({
    dbCon <- dbConnect(SQLite(), file.path(dataDir, "sogp.db"))
    dbWriteTable(dbCon, t, df, overwrite = TRUE)
    dbDisconnect(dbCon)
  })
})
