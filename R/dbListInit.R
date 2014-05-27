#` Initiate connections included in db_list
#'
#' Placeholder function
#' @export
dbListInit <- function(){
  db_list <-  list(
    #Sample SQLite database
    SQLite = list(
      db        = dbConnect(dbDriver('SQLite'), dbname = system.file('data/births.db', package = 'ShinyBuilder')),
      qry_fn    = RJDBC::dbGetQuery,
      smpl_qry  = 'SELECT * FROM births'
    )
  )
  db_list
}




# births    <- read.csv(paste0(getwd(),'/data/births.csv'))
# bnames    <- read.csv(paste0(getwd(),'/data/bnames.csv'))
# sample_db <- dbConnect(dbDriver('SQLite'), dbname = paste0(getwd(),'/data/births.db'))
# dbWriteTable(sample_db, 'births', births)
# dbWriteTable(sample_db, 'bnames', bnames)
# dbGetQuery(sample_db, 'SELECT * FROM births LIMIT 5')
# dbGetQuery(sample_db, 'SELECT * FROM bnames LIMIT 5')
# dbDisconnect(sample_db)
