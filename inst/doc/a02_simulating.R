## ----set-knitr-options, cache=FALSE, echo=FALSE-------------------------------
library("knitr")
opts_chunk$set(message = FALSE, warning=FALSE, fig.width = 5.5)

## ----message=FALSE, warning=FALSE---------------------------------------------
library(zoid)

## -----------------------------------------------------------------------------
y = broken_stick(n_obs = 10,
                        n_groups = 10,
                        tot_n = 100)

## ----eval=FALSE---------------------------------------------------------------
#  y$p
#  y$X_obs

## -----------------------------------------------------------------------------
p = gtools::rdirichlet(1, alpha = rep(2,10))

y = broken_stick(n_obs = 10,
                        n_groups = 10,
                        tot_n = 100,
                 p = p)

