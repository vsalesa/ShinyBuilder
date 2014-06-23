context("ShinyBuilder")

test_that('package functions are present',{
  expect_true(is.function(dbListInit))
  expect_true(is.function(dbListAdd))
  expect_true(is.function(dbListRemove))
  expect_true(is.function(dbListPrint))
})

test_that('DB connections work with sample queries',{
  db_list <- dbListInit()
  lapply(db_list, function(db_obj) expect_is(with(db_obj, do.call(query_fn, list(db, default_query))), 'data.frame'))
})