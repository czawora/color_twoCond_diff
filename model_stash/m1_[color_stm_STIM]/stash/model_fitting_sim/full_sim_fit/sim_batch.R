

library(brms)
library(glue)
library(tidyverse)

source('simulation.R')
source('brms_model.R')

#########################################################################
#########################################################################
#########################################################################

## command line inputs

args <- commandArgs(trailingOnly = TRUE)
sim_path <- args[1]
sim_num <- as.numeric(args[2])

#sink(file(glue("{sim_path}/log.txt"), open = "a"), type = "output")
#sink(file(glue("{sim_path}/log.txt"), open = "a"), type = "message")

#########################################################################
#########################################################################
#########################################################################

nsim_datasets <- 1

sim_priors <- tibble(
  sim_num = sim_num,
  alpha0_mu = rnorm(nsim_datasets, 4, 0.5),
  alpha0_sigma = abs(rnorm(nsim_datasets, 0, 0.5)),
  alphaD_mu =  rnorm(nsim_datasets, 0, 0.5),
  alphaD_sigma = abs(rnorm(nsim_datasets, 0, 0.5)),
  beta0_mu = rnorm(nsim_datasets, 0, 1.5),
  beta0_sigma = abs(rnorm(nsim_datasets, 0, 1.5)),
  betaD_mu = rnorm(nsim_datasets, 0, 1),
  betaD_sigma = abs(rnorm(nsim_datasets, 0, 1)),
  nsubj = 2,
  nobs_per_cond = 126
)

sim_datasets <- sim_priors %>%
  mutate(dataset = pmap(sim_priors, simulateData))

saveRDS(sim_datasets, file = glue("{sim_path}/sim_datasets.rds"))

obs_only <- 
  sim_datasets %>%
  unnest(dataset) %>%
  unnest(subj_obs) %>%
  transmute(subj_index = as_factor(subj), 
            error = obs_radian,
            obs_degree, 
            stimulation)

#########################################################################
#########################################################################
#########################################################################

# priors

bprior <- prior(normal(4, 0.5), class = "b", coef = "intercept", dpar = "circSD") + 
  prior(normal(0, 0.5), class = "b", coef = "stimulation", dpar = "circSD") +
  prior(normal(0, 0.5), class = "sd", coef = "Intercept", dpar = "circSD", group = "subj_index") + 
  prior(normal(0, 0.5), class = "sd", coef = "stimulation", dpar = "circSD", group = "subj_index") + 
  prior(normal(0, 1.5), class = "b", coef = "intercept", dpar = "theta") + 
  prior(normal(0, 1), class = "b", coef = "stimulation", dpar = "theta") +
  prior(normal(0, 1.5), class = "sd", coef = "Intercept", dpar = "theta", group = "subj_index") + 
  prior(normal(0, 1), class = "sd", coef = "stimulation", dpar = "theta", group = "subj_index")


#########################################################################
#########################################################################
#########################################################################

# run model 

model_fit <- brm(formula = bform_full, data = obs_only, prior = bprior, stanvars = stanvars,
                 warmup = 3000, iter = 8000, cores = 4, chains = 4, 
                 control = list(adapt_delta = 0.99), inits = 0,
                 file = glue("{sim_path}/model_fit"))
