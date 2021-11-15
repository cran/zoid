## ----set-knitr-options, cache=FALSE, echo=FALSE-------------------------------
library("knitr")
opts_chunk$set(message = FALSE, warning=FALSE, fig.width = 5.5)
build = "cran"
if(build=="cran") {
  mcmc_iter = 50
} else {
  mcmc_iter = 5000
}

## ---- message=FALSE, warning=FALSE--------------------------------------------
library(zoid)

## -----------------------------------------------------------------------------
data(coddiet)

## -----------------------------------------------------------------------------
design_matrix = coddiet[,names(coddiet)%in%c("Year","Season")==TRUE]
data_matrix = coddiet[,names(coddiet)%in%c("Year","Season")==FALSE]

## ----results="hide", eval=FALSE-----------------------------------------------
#  design_matrix$Season = as.factor(design_matrix$Season)
#  design_matrix$Year = as.factor(design_matrix$Year)
#  design_matrix$y = 1 # dummy variable
#  
#  set.seed(123)
#  fit_1 <- fit_zoid(data_matrix = as.matrix(data_matrix),
#                        overdispersion = TRUE,
#                        chains=4,
#                        iter=4000)
#  
#  fit_2 <- fit_zoid(formula = y ~ Season,
#                        design_matrix = design_matrix,
#                        data_matrix = as.matrix(data_matrix),
#                        overdispersion = TRUE,
#                        chains=4,
#                        iter=4000)
#  
#  fit_3 <- fit_zoid(formula = y ~ Year,
#                        design_matrix = design_matrix,
#                        data_matrix = as.matrix(data_matrix),
#                        overdispersion = TRUE,
#                        chains=4,
#                        iter=4000)
#  
#  fit_4 <- fit_zoid(formula = y ~ Year + Season,
#                        design_matrix = design_matrix,
#                        data_matrix = as.matrix(data_matrix),
#                        overdispersion = TRUE,
#                        chains=4,
#                        iter=4000)

## ----eval=FALSE---------------------------------------------------------------
#  loo_1 = loo::loo(fit_1$model)
#  loo_2 = loo::loo(fit_2$model)
#  loo_3 = loo::loo(fit_3$model)
#  loo_4 = loo::loo(fit_4$model)

## ----warning=FALSE, message=FALSE---------------------------------------------
fit_1 <- fit_zoid(data_matrix = as.matrix(data_matrix), 
                      chains=1,
                      iter=mcmc_iter,
                      overdispersion = TRUE, refresh=0)

fitted_vals = get_fitted(fit_1)
head(fitted_vals)

## -----------------------------------------------------------------------------
fitted_vals = get_pars(fit_1)
head(fitted_vals$betas)

