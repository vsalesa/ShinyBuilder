#` Run ShinyBuilder
#'
#' Run an instance of ShinyBuilder
#' @import shiny
#' @export
runShinyBuilder <- function(){
  shiny::runApp(system.file('', package = 'ShinyBuilder'))
}

#Need function to add/remove dbs to/from db_list.  Also a function to print db list

#Need function to copy app to shiny server dir?
#file.copy(from = c('server.R', 'ui.R', 'global.R'), to = 'your destination')