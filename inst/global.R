#---------
#Libraries
#---------
lib         <- c('reshape2',
                 'stringr',
                 'lubridate',
                 'googleVis',
                 'RJDBC',
                 'RJSONIO',
                 'RSQLite',
                 'shinyAce',
                 'shinyMCE',
                 'shinyGridster')

#Install/load required libraries
for (lib_name in lib){
  if (!require(lib_name, character.only = T)) 
    install.packages(lib_name);
  library(lib_name, character.only = T);
}
source(paste0(getwd(),'/R/googleChart.R'))

#DB list
source(paste0(getwd(),'/R/db_list.R'))  

#Available dashboards
available_dashboards <- str_replace(list.files(str_c(getwd(),'/dashboards')), '.RData', '')