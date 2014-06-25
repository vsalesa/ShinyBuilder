# Copyright (c) 2014 Clear Channel Broadcasting, Inc. 
# https://github.com/iheartradio/ShinyBuilder
# Licensed under the MIT License (MIT)

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
#' @param update logical value indicating whether ShinyBuilder dashboards should be periodically updated by re-running the queries.  True by default.
#' @param times vector specifying update schedule in crontab format (i.e., minute (0-59), hour (0-23), day of month (1-31), month (1-12), day of week (0-6, Sun = 6)).  Defaults to daily updates at 12:00 AM.
#' @examples
#' deployShinyBuilder(dir = '/srv/shiny-server/ShinyBuilder') 
#' @export
deployShinyBuilder <- function(dir, update = T, times = c(0, 0, '*', '*', '*')){  
    #Copy files
    if(!file.exists(dir)) dir.create(dir, mode = '0755')
    if(substr(dir, nchar(dir), nchar(dir)) != '/') dir <- paste0(dir, '/')
    sb_dir <- system.file('', package = 'ShinyBuilder')
    file.copy(from = paste0(sb_dir, c('server.R', 'ui.R', 'global.R')), to = paste0(dir, c('server.R', 'ui.R', 'global.R')), overwrite = T)
    
    #Crontabs
    cron_script   <- "Rscript -e 'ShinyBuilder::updateDashboards()'"
    crontabs      <- try(system('crontab -l', intern = T), silent = T)
    script_index  <- grep(cron_script, crontabs, fixed = T)
    if(length(script_index) == 0) script_index <- length(crontabs) + 1
    ifelse(update,
           crontabs[script_index] <- paste(paste(times, collapse = ' '), cron_script),
           crontabs <- crontabs[-script_index])
    
    #Write out crontabs
    write.table(crontabs, '/tmp/sb_crontabs.csv', row.names = F, col.names = F, quote = F)
    system('crontab < /tmp/sb_crontabs.csv')
    
    message(paste0('ShinyBuilder deployed successfully. Autoupdate: ', ifelse(update, 'ON', 'OFF')))
}