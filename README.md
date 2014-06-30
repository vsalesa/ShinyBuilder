# ShinyBuilder

[![Build Status](https://travis-ci.org/iheartradio/ShinyBuilder.svg?branch=master)](https://travis-ci.org/iheartradio/ShinyBuilder)

ShinyBuilder is a point-and-click dashboard platform based on [R/Shiny](http://www.rstudio.com/shiny/) which makes it simple to create and share live, connected dashboards. To try it out, please see the ShinyBuilder [live demo](https://iheart.shinyapps.io/ShinyBuilder).

ShinyBuilder was created with the following goals:
* __Easy Access__ - Can be accessed from any web browser  
* __Easy Authoring__ - Dashboards are created via a point-and-click GUI, enabling anyone with basic SQL skills to set up a professional dashboard in a matter of minutes.  
* __Instantly Connected__ - ShinyBuilder charts begin as SQL queries, and are immediately linked to a live database.  Once created, the charts are refreshed daily & automatically, eliminating need to build ETL workflows.  
* __Extensible & Modular__ - all major JavaScript libraries used in the project have been wrapped into resusable R/Shiny packages, making it easy to extend ShinyBuilder or to use ShinyBuilder components in your own projects.  

ShinyBuilder components include:
* [shinyGoogleCharts](https://github.com/mul118/shinyGoogleCharts) - functions for displaying and interactively editing [Google Charts](https://developers.google.com/chart/) in Shiny 
* [shinyMCE](https://github.com/mul118/shinyMCE) - integrates [TinyMCE](http://www.tinymce.com/index.php) WYSIWYG text editor into Shiny
* [shinyAce](https://github.com/trestletech/shinyAce) - integrates [Ace](http://ace.c9.io/#nav=about) code editor into Shiny
* [shinyGridster](https://github.com/wch/shiny-gridster) - integrates the [gridster.js](http://gridster.net/) draggable framework into Shiny


## Install 

To install ShinyBuilder, download and install [R](http://www.r-project.org/).  Then from the R console, run:

```r
if (!require("devtools"))
  install.packages("devtools")
devtools::install_github("mul118/shinyMCE")
devtools::install_github("mul118/shinyGridster")
devtools::install_github("iheartradio/ShinyBuilder")
```

If all goes well, you should now be able to run ShinyBuilder locally by typing:

```r
ShinyBuilder::runShinyBuilder()
```

Note: ShinyBuilder was developed and tested for the Mac and Linux platforms.  While `runShinyBuilder` should work on Windows, some admin features may not work properly. 

## Shiny Server 

You can deploy ShinyBuilder to [Shiny Server](http://www.rstudio.com/shiny/server/) by installing the package on the server, then running the `deployShinyBuilder` function:

```r
deployShinyBuilder(dir = '/srv/shiny-server/ShinyBuilder')
```

Please note that by default, ShinyBuilder is set to auto-update all dashboards by registering and periodically running a cron script.  You can enable or disable by setting the `update` argument to `TRUE` or `FALSE`, respectively.  You can also specify the update schedule via the `times` argument, which takes the [crontab](http://www.adminschoice.com/crontab-quick-reference/) format (i.e., minute (0-59), hour (0-23), day of month (1-31), month (1-12), day of week (0-6, Sun = 6)). For example, to update all ShinyBuilder dashboards at 12:00 AM every day, run

```r
deployShinyBuilder(dir = '/srv/shiny-server/ShinyBuilder', update = TRUE, times = c(0, 0, "*", "*", "*"))
```

## Databases

You can connect ShinyBuilder to your databases using the included `dbList` functions. For example to add a SQL Server database, download an appropriate [JDBC driver](http://msdn.microsoft.com/en-us/sqlserver/aa937724.aspx) to the `drv` directory of the installed ShinyBuilder package, install [RJDBC](http://cran.r-project.org/web/packages/RJDBC/index.html), then run the following code:

```r
mssql_db <- quote({
  require(RJDBC)
  sb_drv_dir <- paste0(system.file(package = 'ShinyBuilder'), '/drv')
  dbConnect(
    drv       = JDBC('com.microsoft.sqlserver.jdbc.SQLServerDriver', sb_drv_dir), 
    url       = 'jdbc:sqlserver://server_address', 
    user      = 'user', 
    password  = 'pwd')})
    
mssql_default_query <- "SELECT month, earnings, costs \nFROM monthly_reports_table"

dbListAdd(db_name = 'MSSQL', db = mssql_db, query_fn = RJDBC::dbGetQuery, default_query = mssql_default_query)
```

## Use

Please see the [Sample Dashboard](https://iheart.shinyapps.io/ShinyBuilder) for a mini-tutorial to get you started. If you have any questions, comments, concerns, etc., please feel free to consult the [ShinyBuilder mailing list](https://groups.google.com/forum/#!forum/shinybuilder). 

## Customize

You can customize the look and functinality of ShinyBuilder to suit your needs.  The code can be found in the inst folder, and follows standard Shiny app formatting (i.e., `ui.R`, `server.R`, and `global.R` files).  If you write an improvement, feel free to submit it as a pull request, and we'll review/merge it into the main app.

    