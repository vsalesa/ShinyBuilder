library('RSQLite')

db_list <-  list(
  #Sample SQLite database
  SQLite = list(
    db        = dbConnect(dbDriver('SQLite'), dbname = 'ShinyBuilder/data/births.db')),
    qry_fn    = RJDBC::dbGetQuery,
    smpl_qry  = 'SELECT * FROM births'
  )
)



# births    <- read.csv(paste0(getwd(),'/data/births.csv'))
# bnames    <- read.csv(paste0(getwd(),'/data/bnames.csv'))
# sample_db <- dbConnect(dbDriver('SQLite'), dbname = paste0(getwd(),'/data/births.db'))
# dbWriteTable(sample_db, 'births', births)
# dbWriteTable(sample_db, 'bnames', bnames)
# dbGetQuery(sample_db, 'SELECT * FROM births LIMIT 5')
# dbGetQuery(sample_db, 'SELECT * FROM bnames LIMIT 5')
# dbDisconnect(sample_db)
