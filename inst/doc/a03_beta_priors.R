## ----set-knitr-options, cache=FALSE, echo=FALSE, message=FALSE, warning=FALSE----
library("knitr")
opts_chunk$set(message = FALSE, warning=FALSE, fig.width = 5.5)
build = "cran"
if(build=="cran") {
  draws=100
  iter = 3
} else {
  draws=1000
  iter = 10
}

## ---- message=FALSE, warning=FALSE--------------------------------------------
library(zoid)

## ----eval=FALSE---------------------------------------------------------------
#  fit <- fit_zoid(data, prior_sd = 2)

## -----------------------------------------------------------------------------
set.seed(123)
sd = fit_prior(n_bins = 8, n_draws = draws, target = 1, iterations=iter)

## ----eval=FALSE---------------------------------------------------------------
#  fit <- fit_zoid(data, prior_sd = 1.2)

