## ----set-knitr-options, cache=FALSE, echo=FALSE, message=FALSE, warning=FALSE----
library("knitr")
opts_chunk$set(message = FALSE, warning=FALSE, fig.width = 5.5)
build = "cran"
if(build=="cran") {
  length_out = 10
  mcmc_iter = 50
} else {
  length_out = 4
  mcmc_iter = 5000
}

## ----message=FALSE, warning=FALSE---------------------------------------------
library(zoid)

## -----------------------------------------------------------------------------
data(coddiet)
data_matrix = coddiet[,names(coddiet)%in%c("Year","Season")==FALSE]

## ----results="hide"-----------------------------------------------------------
set.seed(123)
fit_1 <- fit_zoid(data_matrix = as.matrix(data_matrix),
                      overdispersion = TRUE,
                      overdispersion_sd = 5,
                      chains=1,
                      iter=mcmc_iter, refresh=0)

## -----------------------------------------------------------------------------
prior = data.frame("value" = fit_1$overdispersion_prior,
                   "dist"="prior")
post = data.frame("value" = rstan::extract(fit_1$model,"phi")$phi,
                  "dist"="post")

hist(log(fit_1$overdispersion_prior), breaks=seq(-20,20,length.out=100), col=rgb(0,0,1,1/4), xlim=c(-10,10),ylim=c(0,1000), main="Posterior (pink) and prior (blue)", xlab=expression(phi))
hist(log(rstan::extract(fit_1$model,"phi")$phi),breaks=seq(-20,20,length.out=100), col=rgb(1,0,0,1/4), add=T)


## ----results="hide"-----------------------------------------------------------
df = data.frame("sd"=exp(seq(log(0.001),log(0.1),length.out=length_out)),overlap=0)
for(i in 1:nrow(df)) {
  fit_1 <- fit_zoid(data_matrix = as.matrix(data_matrix),
                      overdispersion = TRUE,
                      overdispersion_sd = df$sd[i],
                      chains=1,
                      iter=mcmc_iter, refresh=0)
  df$overlap[i] = length(which(fit_1$overdispersion_prior < max(rstan::extract(fit_1$model,"phi")$phi))) / length(fit_1$overdispersion_prior)
}

## -----------------------------------------------------------------------------
plot(df$sd,df$overlap, xlab="Prior SD", ylab="% Overlap",main="Data units: grams",type="b")

## -----------------------------------------------------------------------------
data_matrix = data_matrix / 1000

## ----results="hide"-----------------------------------------------------------
df = data.frame("sd"=exp(seq(log(0.001),log(20),length.out=length_out)),overlap=0)
for(i in 1:nrow(df)) {
  fit_1 <- fit_zoid(data_matrix = as.matrix(data_matrix),
                      overdispersion = TRUE,
                      overdispersion_sd = df$sd[i],
                      chains=1,
                      iter=mcmc_iter, refresh=0)
  df$overlap[i] = length(which(fit_1$overdispersion_prior < max(rstan::extract(fit_1$model,"phi")$phi))) / length(fit_1$overdispersion_prior)
}

## -----------------------------------------------------------------------------
plot(df$sd,df$overlap, xlab="Prior SD", ylab="% Overlap",main="Data units: kilograms",type="b")

## ----results="hide"-----------------------------------------------------------
data("coddiet")
data_matrix = coddiet[,names(coddiet)%in%c("Year","Season")==FALSE]

fit_1 <- fit_zoid(data_matrix = as.matrix(data_matrix),
                      overdispersion = TRUE,
                      overdispersion_sd = 5,
                      chains=1,
                      iter=mcmc_iter, refresh=0)
fit_2 <- fit_zoid(data_matrix = as.matrix(data_matrix)/1000,
                      overdispersion = TRUE,
                      overdispersion_sd = 5,
                      chains=1,
                      iter=mcmc_iter, refresh=0)

## -----------------------------------------------------------------------------
pars_g = get_fitted(fit_1)
pars_kg = get_fitted(fit_2)
plot(pars_g$hi-pars_g$lo, pars_kg$hi-pars_kg$lo,main="",xlab="95% CI width (g)", ylab="95% CI width (kg)")
abline(0,1,col="red")

