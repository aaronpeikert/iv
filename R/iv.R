#' Independend Validation (IV) using 'rsample'
#'
#' Independend Validation (IV) takes an initial subset of size \code{m}
#' of the data for an analysis. For the assessment a single case of the data is
#' taken. This case is consequently included in the analysis set. This procedure
#' is repeated till all but one cases are included in the analysis set.
#'
#' @param data A data frame.
#' @param m The number of samples in the first assesment set. The current
#' standard value is 20, adapt to your needs.
#' @param ... Not currently used.
#'
#' @return A tibble with classes \code{iv}, \code{rset}, \code{tbl_df},
#' \code{tbl}, and \code{data.frame}. The results include a column for the data
#' split objects and one identification variable. Tries to model the approach of
#' e.g. \code{\link[rsample]{vfold_cv}}.
#'
#' @examples
#' iv(mtcars)
#' iv(mtcars, m = 10)
#'
#' @export

iv <- function(data, m = 20, ...) {
  # modeled after
  # rsample:::vfold_splits
  # rsample:::make_splits
  # rsample:::vfold_complement
  # rsample:::rsplit
  n <- nrow(data)
  indices <- purrr::pmap(
    list(
      analysis = purrr::map(seq.int(m, n - 1), seq_len),
      assessment = seq.int(m + 1, n)),
    list)
  split_objs <- purrr::map(indices, rsample:::make_splits, data, "iv_split")
  ids <- gsub(" ", "0", format(seq.int(m + 1, n)))
  ids <- paste0("Sample", ids)
  rsample:::new_rset(splits = split_objs,
           ids = ids,
           attrib = list(m = m), subclass = c("iv", "rset"))
}

#' @export
print.iv <- function(x, ...) {
  cat("#", pretty(x), "\n")
  class(x) <- class(x)[!(class(x) %in% c("iv", "rset"))]
  print(x)
}

#' @export
pretty.iv <- function(x, ...) {
  details <- attributes(x)
  paste0("Independend Validation with ", details$m, " samples in the start set")
}