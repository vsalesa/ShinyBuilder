context("ShinyBuilder")

test_that('package functions are present',{
  expect_true(is.function(dbListInit))
  expect_true(is.function(dbListAdd))
  expect_true(is.function(dbListRemove))
  expect_true(is.function(dbListPrint))
  expect_true(is.function(deployShinyBuilder))
  expect_true(is.function(runShinyBuilder))
  expect_true(is.function(updateDashboards))
})

test_that('DB connections work with sample queries',{
  db_list <- dbListInit()
  lapply(db_list, function(db_obj) expect_is(with(db_obj, do.call(query_fn, list(db, default_query))), 'data.frame'))
})


test_that('deployShinyBuilder copies files, sets crontab',{
  #Temp paths
  tmp_dir   <- '/tmp/ShinyBuilder'
  tmp_files <- paste0(tmp_dir, '/', c('ui.R', 'server.R', 'global.R'))
  
  #Test deploy
  deployShinyBuilder(tmp_dir)
  expect_true(all(file.exists(tmp_files)))
  
  #Test crontabs
  cron_script   <- "Rscript -e 'ShinyBuilder::updateDashboards()'"
  crontabs      <- try(system('crontab -l', intern = T), silent = T)
  script_detect <- grepl(cron_script, crontabs, fixed = T)
  expect_true(any(script_detect))
  
  #Clean up
  file.remove(tmp_files)
  file.remove(tmp_dir)
})

# test_that('updateDashboards updates dashboards',{
#   sbd_path <- system.file('dashboards', package = 'ShinyBuilder')
#   
# })


