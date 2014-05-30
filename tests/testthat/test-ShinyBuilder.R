context("ShinyBuilder")

test_that('package functions are present',{
  expect_true(is.function(dbListInit))
})