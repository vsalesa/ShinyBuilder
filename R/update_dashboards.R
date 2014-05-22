#chron script: sudo Rscript /srv/shiny-server/shiny-dashboards/dashboards/gridster_dash/update_dashboards.R 
setwd('/srv/shiny-server/shiny-dashboards/dashboards/gridster_dash')

#---------
#Libraries
#---------
lib         <- c('RJDBC', 'RSQLite')

#Install/load required libraries
for (lib_name in lib){
  if (!require(lib_name, character.only = T)) 
    install.packages(lib_name);
  library(lib_name, character.only = T);
}


#---------------------
#Update All Dashboards
#---------------------
source(paste0(getwd(),'/db_list.R'))
dashboard_files <- list.files(path = paste0(getwd(),'/dashboards'), full.names = T)

for (dashboard_file in dashboard_files){
  #Load current dashboard
  load(dashboard_file)
  
  #Update chart data
  for (i in 1:length(dashboard_state)){
    if(str_detect(dashboard_state[[i]]$id, 'gItemPlot')){
      input_query               <- dashboard_state[[i]]$query
      db_obj                    <- db_list[[dashboard_state[[i]]$db_name]]
      dashboard_state[[i]]$data <- do.call(db_obj$qry_fn, list(db_obj$db, input_query))
    }
  }
  #Save current dashboard
  save(dashboard_state, file = dashboard_file)
}

