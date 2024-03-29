test_that("rsample gives same result as manual version", {
  #----manual----
  # checked by von Oertzen
  m <- 20
  n <- 1e4
  rand <- rnorm(n)
  result <- vector("numeric", n-m)
  for(i in seq_along(result)){
    result[i] <- mean(rand[seq_len(i + m - 1)])
  }
  rmse <- function(x, y = 0)sqrt(mean((x-y)^2))
  manual <- rmse(rand[-seq_len(m)], result)

  #----rsample----
  d <- tibble::tibble(x = rand)
  rs_obj <- iv(d, m = 20)

  holdout_mean <- function(splits, formula, ...){
    stopifnot(purrr::is_formula(formula))
    var <- as.character(formula)[2]
    est <- mean(rsample::analysis(splits)[[var]])
    error <- rsample::assessment(splits)[[var]] - est
  }

  rsample <- rmse(purrr::map_dbl(rs_obj$splits, holdout_mean , ~x))

  #----compare----
  expect_equal(rsample, manual)
})
