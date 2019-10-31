

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
mu\\_\\alpha_0 &\\sim Normal(?, ?)\\\\
sigma\\_\\alpha_0 &\\sim Normal^+(?, ?) \\\\
mu\\_\\alpha_{\\Delta} &\\sim Normal(?, ?)\\\\
sigma\\_\\alpha_{\\Delta} &\\sim Normal^+(?, ?)\\\\
mu\\_\\beta_0 &\\sim Normal(?, ?)\\\\
sigma\\_\\beta_0 &\\sim Normal^+(?, ?)\\\\
mu\\_\\beta_{\\Delta} &\\sim Normal(?, ?)\\\\
sigma\\_\\beta_{\\Delta} &\\sim Normal^+(?, ?)\\\\
\\end{aligned}
$$
"


##############################################
# prior predictive check 


prior_check_top_notes_str <- ""

sample_size_notes_str <- ""

correct_check_notes_str <- ""

vm_mean_prior_notes_str <- ""

vm_pred_notes_str <- ""

pMem_mean_prior_notes_str <- ""

pMem_pred_notes_str <- ""

obs_pred_notes_str <- ""

##############################################
# model fit

fit_qc_notes_str <- ""

posterior_notes_str <- ""

posterior_pred_notes_str <- ""

##############################################
# loo

loo_notes_str <- ""