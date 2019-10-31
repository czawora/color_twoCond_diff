# define prior
# priors

require(brms)

# alpha0_mu ~ normal(3.8, 0.5)
alpha0_mu_prior_mu <- 3.8
alpha0_mu_prior_sd <- 0.5

# alpha0_sigma ~ half_normal(0, 0.5)
alpha0_sigma_prior_mu <- 0
alpha0_sigma_prior_sd <- 0.5

# alphaD_mu ~ normal(0, 0.5)
alphaD_mu_prior_mu <- 0
alphaD_mu_prior_sd <- 0.5

# alphaD_sigma ~ half_normal(0, 0.5)
alphaD_sigma_prior_mu <- 0
alphaD_sigma_prior_sd <- 0.5

# beta0_mu ~ normal(0, 1.5)
beta0_mu_prior_mu <- 0
beta0_mu_prior_sd <- 1.5

# beta0_simga ~ half_normal(0, 1)
beta0_sigma_prior_mu <- 0
beta0_sigma_prior_sd <- 1

# betaD_mu ~ normal(0, 1.5)
betaD_mu_prior_mu <- 0
betaD_mu_prior_sd <- 1.5

# betaD_sigma ~ half_normal(0, 1)
betaD_sigma_prior_mu <- 0
betaD_sigma_prior_sd <- 1



alpha0_mu_prior_str <- glue("normal({alpha0_mu_prior_mu}, {alpha0_mu_prior_sd})")
alpha0_simga_prior_str <- glue("normal({alpha0_sigma_prior_mu}, {alpha0_sigma_prior_sd})")
alphaD_mu_prior_str <- glue("normal({alphaD_mu_prior_mu}, {alphaD_mu_prior_sd})")
alphaD_sigma_prior_str <- glue("normal({alphaD_sigma_prior_mu}, {alphaD_sigma_prior_sd})")
beta0_mu_prior_str <- glue("normal({beta0_mu_prior_mu}, {beta0_mu_prior_sd})")
beta0_sigma_prior_str <- glue("normal({beta0_sigma_prior_mu}, {beta0_sigma_prior_sd})")
betaD_mu_prior_str <- glue("normal({betaD_mu_prior_mu}, {betaD_mu_prior_sd})")
betaD_sigma_prior_str <- glue("normal({betaD_sigma_prior_mu}, {betaD_sigma_prior_sd})")




# use in loo and model fitting
bprior_full <- 
  prior_string(alpha0_mu_prior_str, class = "b", coef = "intercept", dpar = "circSD") + 
  prior_string(alphaD_mu_prior_str, class = "b", coef = "stimulation", dpar = "circSD") +
  prior_string(alpha0_simga_prior_str, class = "sd", coef = "Intercept", dpar = "circSD", group = "subj") + 
  prior_string(alphaD_sigma_prior_str, class = "sd", coef = "stimulation", dpar = "circSD", group = "subj") + 
  prior_string(beta0_mu_prior_str, class = "b", coef = "intercept", dpar = "theta") + 
  prior_string(betaD_mu_prior_str, class = "b", coef = "stimulation", dpar = "theta") +
  prior_string(beta0_sigma_prior_str, class = "sd", coef = "Intercept", dpar = "theta", group = "subj") + 
  prior_string(betaD_sigma_prior_str, class = "sd", coef = "stimulation", dpar = "theta", group = "subj")

# use the rest only in loo
bprior_DcircSD_null <- 
  prior_string(alpha0_mu_prior_str, class = "b", coef = "intercept", dpar = "circSD") + 
  #prior_string(alphaD_mu_prior_str, class = "b", coef = "stimulation", dpar = "circSD") +
  prior_string(alpha0_simga_prior_str, class = "sd", coef = "Intercept", dpar = "circSD", group = "subj") + 
  prior_string(alphaD_sigma_prior_str, class = "sd", coef = "stimulation", dpar = "circSD", group = "subj") + 
  prior_string(beta0_mu_prior_str, class = "b", coef = "intercept", dpar = "theta") + 
  prior_string(betaD_mu_prior_str, class = "b", coef = "stimulation", dpar = "theta") +
  prior_string(beta0_sigma_prior_str, class = "sd", coef = "Intercept", dpar = "theta", group = "subj") + 
  prior_string(betaD_sigma_prior_str, class = "sd", coef = "stimulation", dpar = "theta", group = "subj")

bprior_DpMem_null <- 
  prior_string(alpha0_mu_prior_str, class = "b", coef = "intercept", dpar = "circSD") + 
  prior_string(alphaD_mu_prior_str, class = "b", coef = "stimulation", dpar = "circSD") +
  prior_string(alpha0_simga_prior_str, class = "sd", coef = "Intercept", dpar = "circSD", group = "subj") + 
  prior_string(alphaD_sigma_prior_str, class = "sd", coef = "stimulation", dpar = "circSD", group = "subj") + 
  prior_string(beta0_mu_prior_str, class = "b", coef = "intercept", dpar = "theta") + 
  #prior_string(betaD_mu_prior_str, class = "b", coef = "stimulation", dpar = "theta") +
  prior_string(beta0_sigma_prior_str, class = "sd", coef = "Intercept", dpar = "theta", group = "subj") + 
  prior_string(betaD_sigma_prior_str, class = "sd", coef = "stimulation", dpar = "theta", group = "subj")

bprior_DcircSD_DpMem_null <- 
  prior_string(alpha0_mu_prior_str, class = "b", coef = "intercept", dpar = "circSD") + 
  #prior_string(alphaD_mu_prior_str, class = "b", coef = "stimulation", dpar = "circSD") +
  prior_string(alpha0_simga_prior_str, class = "sd", coef = "Intercept", dpar = "circSD", group = "subj") + 
  prior_string(alphaD_sigma_prior_str, class = "sd", coef = "stimulation", dpar = "circSD", group = "subj") + 
  prior_string(beta0_mu_prior_str, class = "b", coef = "intercept", dpar = "theta") + 
  #prior_string(betaD_mu_prior_str, class = "b", coef = "stimulation", dpar = "theta") +
  prior_string(beta0_sigma_prior_str, class = "sd", coef = "Intercept", dpar = "theta", group = "subj") + 
  prior_string(betaD_sigma_prior_str, class = "sd", coef = "stimulation", dpar = "theta", group = "subj")

