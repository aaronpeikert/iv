library("purrr")
rs_obj <- iv(mtcars, m = 10)

test_that("iv has allways an assesment set with one row", {
  nrow <- map(rs_obj$splits, ~nrow(rsample::assessment(.x)))
  expect_true(all(nrow == 1))
})

test_that("iv has class 'rset' and 'iv'", {
  expect_true(inherits(rs_obj, "rset"))
  expect_true(inherits(rs_obj, "iv"))
})
