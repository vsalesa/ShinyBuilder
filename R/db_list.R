db_list <-  list(
  #Sample SQLite database
  SQLite = list(
    db        = dbConnect(dbDriver('SQLite'), dbname = paste0(getwd(),'/data/births.db')),
    qry_fn    = RJDBC::dbGetQuery,
    smpl_qry  = 'SELECT * FROM births'
  )
)



# births    <- read.csv(paste0(getwd(),'/data/births.csv'))
# sample_db <- dbConnect(dbDriver('SQLite'), dbname = paste0(getwd(),'/data/births.db'))
# dbWriteTable(sample_db, 'births', births)
# dbGetQuery(sample_db, 'SELECT * FROM births')
# dbDisconnect(sample_db)