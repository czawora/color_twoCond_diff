

math_model_str <- "
$$
\\begin{aligned}
\\mathrm{-likelihood-} \\\\
error_i &\\sim (pMem_i)*VM(0, \\kappa_i) + (1 - pMem_i)*Unif(-\\pi,\\pi) \\\\
\\\\
\\mathrm{-param~transformation-} \\\\
\\kappa_i &= sd2k(circ\\_sd_i) \\\\
\\\\
\\mathrm{-linear~model-} \\\\
circ\\_sd_i &= exp(\\alpha_{0,SUBJ[i]} + \\alpha_{\\Delta,SUBJ[i]} * postCond) ~~ \\mathrm{-log~link~on~circSD-} \\\\
pMem_i &= inv\\_logit(\\beta_{0,SUBJ[i]} + \\beta_{\\Delta,SUBJ[i]} * postCond) ~~ \\mathrm{-logit~link~on~pMem-} \\\\
\\\\
\\mathrm{-priors:~all~independent-}\\\\
\\alpha_{0,SUBJ[...]} &\\sim Normal(mu\\_\\alpha_0, sigma\\_\\alpha_0) \\\\
\\alpha_{\\Delta,SUBJ[...]} &\\sim Normal(mu\\_\\alpha_{\\Delta}, sigma\\_\\alpha_{\\Delta}) \\\\
\\beta_{0,SUBJ[...]} &\\sim Normal(mu\\_\\beta_0, sigma\\_\\beta_0) \\\\
\\beta_{\\Delta,SUBJ[...]} &\\sim Normal(mu\\_\\beta_{\\Delta}, sigma\\_\\beta_{\\Delta}) \\\\
\\\\
mu\\_\\alpha_0 &\\sim Normal(3.8, 0.4)\\\\
sigma\\_\\alpha_0 &\\sim Normal^+(0, 0.25) \\\\
mu\\_\\alpha_{\\Delta} &\\sim Normal(0, 0.4)\\\\
sigma\\_\\alpha_{\\Delta} &\\sim Normal^+(0, 0.25)\\\\
mu\\_\\beta_0 &\\sim Normal(0, 1.5)\\\\
sigma\\_\\beta_0 &\\sim Normal^+(0, 0.5)\\\\
mu\\_\\beta_{\\Delta} &\\sim Normal(0, 1)\\\\
sigma\\_\\beta_{\\Delta} &\\sim Normal^+(0, 0.5)\\\\
\\\\
\\\\
\\mathrm{-changes~from~m1-}\\\\
mu\\_\\alpha_0 \\sim Normal(4, 0.5) ~~ ...~&to~... ~~ mu\\_\\alpha_0 \\sim Normal(3.8, 0.4) \\\\
mu\\_\\alpha_{\\Delta} \\sim Normal(0, 0.5) ~~ ...~&to~... ~~ mu\\_\\alpha_{\\Delta} \\sim Normal(0, 0.4)\\\\
\\\\
sigma\\_\\alpha_0 \\sim Normal^+(0, 0.5) ~~ ...~&to~... ~~ sigma\\_\\alpha_0 \\sim Normal^+(0, 0.25) \\\\
sigma\\_\\beta_0 \\sim Normal^+(0, 1.5) ~~ ...~&to~... ~~ sigma\\_\\beta_0 \\sim Normal^+(0, 0.5) \\\\
\\\\
sigma\\_\\alpha_\\Delta \\sim Normal^+(0, 0.5) ~~ ...~&to~... ~~ sigma\\_\\alpha_\\Delta \\sim Normal^+(0, 0.25) \\\\
sigma\\_\\beta_\\Delta \\sim Normal^+(0, 1) ~~ ...~&to~... ~~ sigma\\_\\beta_\\Delta \\sim Normal^+(0, 0.5)\\\\
\\end{aligned}
$$
"


##############################################
# prior predictive check 


prior_check_top_notes_str <- ""

sample_size_notes_str <- "
2 subjs with 252 observations each, 126 per condition. 

9/12 - I am thinking I should simulate varying effects using the actual samples sizes I have. I also think that this shouldnt matter (at least for a model like this). I'll also try with a larger number of subjects.
"

correct_check_notes_str <- ""

vm_mean_prior_notes_str <- "
"
vm_pred_notes_str <- "
"

pMem_mean_prior_notes_str <- "
"

pMem_pred_notes_str <- "
"

obs_pred_notes_str <- "
"

##############################################
# model fit

fit_qc_notes_str <- ""
posterior_notes_str <- ""
posterior_pred_notes_str <- ""

##############################################
# loo

loo_notes_str <- "
"