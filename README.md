
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Independend Validation (IV)

<!-- badges: start -->

[![License:
MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Ask Me Anything
\!](https://img.shields.io/badge/Ask%20me-anything-1abc9c.svg)](https://github.com/aaronpeikert/iv/issues/new)
<!-- badges: end -->

Independend Validation is a procedure proposed by von Oertzen (in prep),
which produces independend assessment sets. This property is assumed
when performing most statistical tests on the performance measures
associated with the assesment sets. Importantly classical resampling
procedures (like cross validation or bootstrapping) do violate this
assumption, because even when the original sample are independend, the
resulting assesment and holdout sets are not.

## Installation

You can install the development version from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("aaronpeikert/iv")
```

## Examples

``` r
library(rsample)
#> Loading required package: tidyr
data("attrition")
# downsample
attrition <- attrition[sample(seq_len(nrow(attrition)), 100), ]
```

``` r
library(iv)
iv_obj <- iv(attrition, m = 20)
iv_obj
#> # Independend Validation with 20 samples in the start set 
#> # A tibble: 80 x 2
#>    splits         id       
#>    <list>         <chr>    
#>  1 <split [20/1]> Sample021
#>  2 <split [21/1]> Sample022
#>  3 <split [22/1]> Sample023
#>  4 <split [23/1]> Sample024
#>  5 <split [24/1]> Sample025
#>  6 <split [25/1]> Sample026
#>  7 <split [26/1]> Sample027
#>  8 <split [27/1]> Sample028
#>  9 <split [28/1]> Sample029
#> 10 <split [29/1]> Sample030
#> # … with 70 more rows
```

``` r
mod_form <- as.formula(Attrition ~ JobSatisfaction + Gender + MonthlyIncome)
## splits will be the `rsplit` object
holdout_results <- function(splits, ...) {
  # Fit the model to the 90%
  mod <- glm(..., data = analysis(splits), family = binomial)
  # Save the 10%
  holdout <- assessment(splits)
  # `augment` will save the predictions with the holdout data set
  res <- broom::augment(mod, newdata = holdout)
  # Class predictions on the assessment set from class probs
  lvls <- levels(holdout$Attrition)
  predictions <- factor(ifelse(res$.fitted > 0, lvls[2], lvls[1]),
                        levels = lvls)
  # Calculate whether the prediction was correct
  res$correct <- predictions == holdout$Attrition
  # Return the assessment data set with the additional columns
  res
}
```

``` r
library(purrr)
iv_obj$results <- map(iv_obj$splits,
                      holdout_results,
                      mod_form)
iv_obj$accuracy <- map_dbl(iv_obj$results, function(x) mean(x$correct))
summary(iv_obj$accuracy)
#>    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
#>  0.0000  0.0000  0.0000  0.4875  1.0000  1.0000
```

by [Aaron Peikert![ORCID
iD](https://orcid.org/sites/default/files/images/orcid_16x16.png)](https://orcid.org/0000-0001-7813-818X)
and [Andreas Brandmaier![ORCID
iD](https://orcid.org/sites/default/files/images/orcid_16x16.png)](http://orcid.org/0000-0001-8765-6982).
