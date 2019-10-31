
#########################################################################
#########################################################################
#########################################################################

library(brms)
library(tidyverse)

source('simulation.R')
source('brms_model.R')

#########################################################################
#########################################################################
#########################################################################

# priors

bprior <- prior(normal(4, 0.5), class = "b", coef = "intercept", dpar = "circSD") + 
  prior(normal(0, 0.5), class = "b", coef = "stimulation", dpar = "circSD") +
  prior(normal(0, 0.5), class = "sd", coef = "Intercept", dpar = "circSD", group = "subj_index") + 
  prior(normal(0, 0.5), class = "sd", coef = "stimulation", dpar = "circSD", group = "subj_index") + 
  prior(normal(0, 1.5), class = "b", coef = "intercept", dpar = "theta") + 
  prior(normal(0, 1.5), class = "b", coef = "stimulation", dpar = "theta") +
  prior(normal(0, 1), class = "sd", coef = "Intercept", dpar = "theta", group = "subj_index") + 
  prior(normal(0, 1), class = "sd", coef = "stimulation", dpar = "theta", group = "subj_index")

# generate dataset from prior

nsim_datasets <- 1

sim_priors <- tibble(
  sim_num = 1,
  alpha0_mu = rnorm(nsim_datasets, 3.7, 0.4),
  alpha0_sigma = abs(rnorm(nsim_datasets, 0, 0.25)),
  alphaD_mu =  rnorm(nsim_datasets, 0, 0.4),
  alphaD_sigma = abs(rnorm(nsim_datasets, 0, 0.25)),
  beta0_mu = rnorm(nsim_datasets, 0, 1.5),
  beta0_sigma = abs(rnorm(nsim_datasets, 0, 0.5)),
  betaD_mu = rnorm(nsim_datasets, 0, 1),
  betaD_sigma = abs(rnorm(nsim_datasets, 0, 0.5)),
  nsubj = nsubj_sim,
  nobs_per_cond = nobs_per_cond_sim
)

sim_dataset <- sim_priors %>%
  transmute(dataset = pmap(sim_priors, simulateData)) %>%
  unnest(dataset) %>%
  unnest(subj_obs) %>%
  mutate(error = obs_radian,
         subj_index = subj) %>%
  select(subj_index, error, stimulation)
  
  


#########################################################################
#########################################################################
#########################################################################

# run model 

model_fit <- brm(formula = bform, data = sim_dataset, prior = bprior, stanvars = stanvars,
                 warmup = 3000, iter = 8000, cores = 4, chains = 4, control = list(adapt_delta = 0.99), inits = 0,
                 file = "m1_prior_only")
