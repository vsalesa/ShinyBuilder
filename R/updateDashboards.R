#' Update All Dashboards
#' 
#' @param dashboards a vector of dashboard names.  By default, all dashboards in the dashboards directory are updated
#' @export 
#' @examples
#' updateDashboards()
updateDashboards <- function(dashboards = NULL){
  
  if(is.null(dashboards)) 
    #dashboards <- list.files(path = paste0(getwd(),'/dashboards'), full.names = T)
    dashboards <- list.files(path = system.file('dashboards', package = 'ShinyBuilder'), full.names = T)
  
  db_list <- dbListInit()
  #source('ShinyBuilder/R/db_list.R')

  for (dashboard_file in dashboards){
    #Load current dashboard
    load(dashboard_file)
    print(paste0('Updating ', dashboard_file))
    
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
}