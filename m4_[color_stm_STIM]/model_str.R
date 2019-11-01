

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
Extreme mean effects are far more contained.
"
vm_pred_notes_str <- "
Predictive distribution of subject are more contained pre/post and group-level SD is better contained.

Still a lot probability on extreme max values, but overall these priors seem much more resonable.
"

pMem_mean_prior_notes_str <- "
No changes to this.
"

pMem_pred_notes_str <- "
Though, the prior on group-level variance was narrowed and that makes these subject pred dists look much better. Less extreme values.
"

obs_pred_notes_str <- "
Clearly no predicted effect. Post condition shows the same, expected increase in subject pred dist variance.
"

##############################################
# model fit

fit_qc_notes_str <- "All looks good."
posterior_notes_str <- "Seems good in that there is consistent reduction in uncertainty from prior to posterior. 

I should come up with a better plot to show the posterior estimates of group-level variance.
"
posterior_pred_notes_str <- "Both the reduction in uncertainty and the hint of an effect are visible in the marginal subject plot and the average subject plot."

##############################################
# loo

loo_notes_str <- "
Same ordering of waic differences as in m6.


WAIC diffs were not very large and had non-neglible SE. Also inconclusive.

waic diff ordering:

-fit_DpMem_null      

-fit_DcircSD_DpMem_null 

-fit_full               

-fit_DcircSD_null

fit_DpMem_null predicted best since it omits the difference parameter on pMem, for which there seems little evidence of an effect.

fit_DcircSD_null fit worst since it omits the parameter that seems to be actually showing a non-zero value. 

fit_full and fit_DcircSD_DpMem_null are in the middle.
"