
source('/Users/zaworaca/Desktop/Desktop/zane/color_twoCond_diff/common/simulation.R')

nsubj_sim <- 3
nobs_per_cond_sim <- 126

sim_priors <- tibble(
  sim_num = 1,
  alpha0_mu = 4,
  alpha0_sigma = 0.5,
  alphaD_mu =  0,
  alphaD_sigma = 0.5,
  beta0_mu = 0,
  beta0_sigma = 1.5,
  betaD_mu = 0,
  betaD_sigma = 1,
  nsubj = nsubj_sim,
  nobs_per_cond = nobs_per_cond_sim
)

sim_dataset <- sim_priors %>%
  mutate(dataset = pmap(sim_priors, simulateData)) %>%
  unnest(dataset)

saveRDS(sim_dataset, 
        file = "/Users/zaworaca/Desktop/Desktop/zane/color_twoCond_diff/m1_[color_stm_STIM]/single_sim_fit/expected_single_sim.rds")


