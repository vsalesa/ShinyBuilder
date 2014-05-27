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
source(system.file('googleChart.R', package = 'ShinyBuilder'))

#DB list
db_list <- dbListInit()

#Available dashboards
available_dashboards <- str_replace(list.files(path = system.file('dashboards', package = 'ShinyBuilder')), '.RData', '')