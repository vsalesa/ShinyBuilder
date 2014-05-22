# ShinyDash

ShinyDash is a point-and-click dashboard platform based on [R/Shiny](http://www.rstudio.com/shiny/) which makes it simple to create and share live, connected dashboards.

ShinyDash was created with the following goals:
* __Easy Access__ - Can be accessed from any web browser  
* __Easy Authoring__ - Dashboards are created via a point-and-click GUI, enabling anyone with basic SQL skills to set up a professional dashboard in a matter of minutes.  
* __Instantly Connected__ - ShinyDash charts begin as SQL queries, and are immediately linked to a live database.  Once created, the charts are refreshed daily & automatically, eliminating need to build ETL workflows.  
* __Extensible & Modular__ - all major JavaScript libraries used in the project have been wrapped into resusable R/Shiny packages, making it easy to extend ShinyDash or to use ShinyDash components in your own projects.  

ShinyDash components include:
    * [shinyGoogleCharts](https://github.com/mul118/shinyGoogleCharts) - functions for displaying and interactively editing [Google Charts](https://developers.google.com/chart/) in Shiny 
    * [shinyMCE](https://github.com/mul118/shinyMCE) - integrates [TinyMCE](http://www.tinymce.com/index.php) WYSIWYG text editor into Shiny
    * [shinyAce](https://github.com/trestletech/shinyAce) - integrates [Ace](http://ace.c9.io/#nav=about) code editor into Shiny
    * [shinyGridster](https://github.com/wch/shiny-gridster) - integrates the [gridster.js](http://gridster.net/) draggable framework into Shiny


## Install 

To install, run

```r
if (!require("devtools"))
  install.packages("devtools")
devtools::install_github("shinyDash", "mul118")
```

If want to run ShinyDash from server, install Shiny Server [Shiny Server](http://www.rstudio.com/shiny/server/)

## Configure

* Add information for your database(s) of choice to the db_list.R file
* Set up cron job to update all dashboards by running the update_dashboards.R script 

```
sudo Rscript /srv/shiny-server/shiny-dashboards/dashboards/gridster_dash/update_dashboards.R 
```

## Use

Live demo available __here__.



    