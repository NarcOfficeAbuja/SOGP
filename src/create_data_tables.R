# Create data tables

library(RSQLite)

dataDir <- file.path(here::here(), "data")
if(!dir.exists(dataDir))
  dir.create(dataDir)

csvFiles <- 
  if (interactive()) 
    c("bot-list.csv", "mail_Jul_2019.csv", "media.csv") else
      commandArgs(trailingOnly = TRUE)

tableNames <- substr(csvFiles, 1, regexpr("\\.csv$", csvFiles) - 1)

purrr::map2(csvFiles, tableNames, function(x, y) {
  csv <- file.path(dataDir, x)
  df <- read.csv(csv, stringsAsFactors = TRUE)
  try({
    dbCon <- dbConnect(SQLite(), file.path(dataDir, "sogp.db"))
    dbWriteTable(dbCon, y, df, overwrite = TRUE)
    dbDisconnect(dbCon)
  })
})
