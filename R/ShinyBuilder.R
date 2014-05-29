#` Run ShinyBuilder
#'
#' Run an instance of ShinyBuilder
#' @import shiny
#' @export
runShinyBuilder <- function(){
  shiny::runApp(system.file('', package = 'ShinyBuilder'))
}

#' Deploy ShinyBuilder to a specified directory
#' 
#' Deploy ShinyBuilder app (ui.R, server.R, global.R) to a specified directory. 
#' Useful for copying ShinyBuilder to a Shiny Server directory from which it will be served.
#' Note that regardless of its deploy location, the app will use the ShinyBuilder library
#' location for saving/loading dashboards, databases, and config files.
#' @param dir directory to which ShinyBuilder app is deployed
#' @examples
#' debployShinyBuilder(dir = '/srv/shiny-server/ShinyBuilder') 
#' @export
deployShinyBuilder <- function(dir){
    sb_dir <- system.file('', package = 'ShinyBuilder')
    if(substr(dir, nchar(dir), nchar(dir)) != '/')
      dir <- paste0(dir, '/')
    
    file.copy(from = paste0(sb_dir, c('server.R', 'ui.R', 'global.R')), to = paste0(dir, c('server.R', 'ui.R', 'global.R')))
}