
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Independend Validation (IV)

<!-- badges: start -->

[![License:
MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Ask Me Anything
\!](https://img.shields.io/badge/Ask%20me-anything-1abc9c.svg)](https://github.com/aaronpeikert/iv/issues/new)
<!-- badges: end -->

Independend Validation is a procedure proposed by von Oertzen, which
produces independend assessment sets. This property is assumed when
performing most statistical tests on the performance measures associated
with the assesment sets. Importantly classical resampling procedures
(like cross validation or bootstrapping) do violate this assumption,
because even when the original sample are independend, the resulting
assesment and holdout sets are not.

## Installation

You can install the development version from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("aaronpeikert/iv")
```

by Aaron Peikert[![ORCID
iD](https://orcid.org/sites/default/files/images/orcid_16x16.png)](https://orcid.org/0000-0001-7813-818X)
and Andreas Brandmaier [![ORCID
iD](https://orcid.org/sites/default/files/images/orcid_16x16.png)](http://orcid.org/0000-0001-8765-6982).
