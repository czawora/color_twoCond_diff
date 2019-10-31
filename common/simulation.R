# #########################################################################
# #########################################################################
# #########################################################################
# #########################################################################
# simulation code

require(tidyverse)
require(glue)

rvonmises_vec <- Vectorize(function(n, mu, k){
  Rfast::rvonmises(n, mu, k)
})

inv_logit_scalar <- function(x){
  return(exp(x)/(exp(x) + 1))
}
inv_logit <- Vectorize(inv_logit_scalar)


sd2k <- function(sd_input) {
  
  #sd_input needs to be radians
  
  #original matlab code
  # R <- exp(-S.^2/2);
  # K = 1./(R.^3 - 4 * R.^2 + 3 * R);
  # K(R < 0.85) = -0.4 + 1.39 * R(R < 0.85) + 0.43./(1 - R(R < 0.85));
  # K(R < 0.53) = 2 * R(R < 0.53) + R(R < 0.53).^3 + (5 * R(R < 0.53).^5)/6;
  
  R <- exp(-(sd_input^2)/2)
  K <- 1/((R^3) - (4 * R^2) + (3*R))
  
  if(R < 0.85){
    K <- -0.4 + (1.39 * R) + (0.43/(1-R))
  }
  
  if(R < 0.53){
    K <- (2 * R) + R^3 + (5 * R^5)/6
  }
  
  
  return(K)
}
sd2k_vec <- Vectorize(sd2k)


# this function takes a single set of likelihood parameters and covariates and simlates an observation from the mixture model
simulateData_likelihood <- function(pMem,
                                    k,
                                    nobs = 1){
  
  # which part of the mixture does this obs come from
  memFlip <- rbernoulli(nobs, pMem)
  
  obs <- memFlip * ( Rfast::rvonmises(nobs, pi, k) - pi) + (1 - memFlip) * runif(nobs, -pi, pi)
  obs <- as.numeric(obs)
  
  obs_tibble <- tibble(obs_radian = obs, obs_degree = pracma::rad2deg(obs))
  
  return(obs_tibble)   
  
}

# this function will take a single set of subject-level parameters and then simulate data for each condition
draw_subj_obs <- function(subj_alpha0, subj_alphaD,
                          subj_beta0, subj_betaD){
  
  conditions <- c(0,1)
  stimulation <- rep(conditions, each = nobs_per_condition)
  
  params <- list(pMem = inv_logit(subj_beta0 + (subj_betaD * stimulation)),
                 k = sd2k_vec(
                   pracma::deg2rad(
                     exp(subj_alpha0 + (subj_alphaD * stimulation)))))
  
  subj_obs <- pmap_dfr(params, simulateData_likelihood) %>%
    cbind(stimulation)
  
  return(subj_obs)
}

# this function will take a single set of  parameters and then simulate a group of subjects
draw_subj <- function(sim_num, 
                      alpha0_mu, alpha0_sigma,
                      alphaD_mu, alphaD_sigma,
                      beta0_mu, beta0_sigma,
                      betaD_mu, betaD_sigma,
                      nsubj = 100, nobs_per_condition = 100){
  
  # generate lower level subject-specific parameters
  sim_subj_alpha0 <- rnorm(nsubj, alpha0_mu, alpha0_sigma)
  sim_subj_alphaD <- rnorm(nsubj, alphaD_mu, alphaD_sigma)
  
  sim_subj_beta0 <- rnorm(nsubj, beta0_mu, beta0_sigma)
  sim_subj_betaD <- rnorm(nsubj, betaD_mu, betaD_sigma)
  
  sim_data <- tibble(
    subj = 1:nsubj,
    subj_alpha0 = sim_subj_alpha0,
    subj_alphaD = sim_subj_alphaD,
    subj_beta0 = sim_subj_beta0,
    subj_betaD = sim_subj_betaD,
    nobs_per_condition = nobs_per_condition
  )
  
  return(sim_data)
}
