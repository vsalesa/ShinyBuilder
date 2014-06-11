#---------
#Libraries
#---------
lib         <- c('stringr',
                 'googleVis',
                 'RJDBC',
                 'RJSONIO',
                 'RSQLite',
                 'shinyAce',
                 'shinyMCE',
                 'shinyGridster',
                 'ShinyBuilder')

#Install/load required libraries
for (lib_name in lib){
  if (!require(lib_name, character.only = T)) 
    install.packages(lib_name);
  library(lib_name, character.only = T);
}
source(system.file('googleChart.R', package = 'ShinyBuilder'))

#DB list
db_list <- dbListInit()

#Shinybuilder directory
sb_dir <- system.file('', package = 'ShinyBuilder')

#Available dashboards
available_dashboards <- str_replace(list.files(path = str_c(sb_dir,'dashboards')), '.RData', '')



