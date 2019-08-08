library(RSQLite)

tryCatch({
  connected <-
    dbConnect(SQLite(), file.path(here::here(), "data", "sogp.db"))
  tbls <- dbListTables(connected)
  prompt <- "Choose a table:"
  if (interactive())
    choice <- menu(tbls, title = prompt)
  else {
    cat("Choose a table:\n\n")
    modTbls <- paste(seq_along(tbls), tbls, sep = ": ")
    cat(modTbls, sep = "\n")
    cat("\nEnter value: ")
    choice <- as.numeric(readLines("stdin", n = 1L))
  }
  dat <- dbReadTable(connected, tbls[choice])
}, finally = dbDisconnect(connected))

if (interactive())
  View(dat) else 
    dplyr::tbl_df(dat)
