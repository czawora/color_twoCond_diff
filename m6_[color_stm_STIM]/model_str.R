

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
mu\\_\\alpha_0 &\\sim Normal(3.8, 0.5)\\\\
sigma\\_\\alpha_0 &\\sim Normal^+(0, 0.5) \\\\
mu\\_\\alpha_{\\Delta} &\\sim Normal(0, 0.5)\\\\
sigma\\_\\alpha_{\\Delta} &\\sim Normal^+(0, 0.5)\\\\
mu\\_\\beta_0 &\\sim Normal(0, 1.5)\\\\
sigma\\_\\beta_0 &\\sim Normal^+(0, 1.5)\\\\
mu\\_\\beta_{\\Delta} &\\sim Normal(0, 1)\\\\
sigma\\_\\beta_{\\Delta} &\\sim Normal^+(0, 1)\\\\
\\\\
\\\\
\\\\
\\mathrm{-model~changes~from~m1-}\\\\
mu\\_\\alpha_0 \\sim Normal(4, 0.5) ~~ ...~&to~... ~~ mu\\_\\alpha_0 \\sim Normal(3.8, 0.5) \\\\
\\end{aligned}
$$
"


##############################################
# prior predictive check 


prior_check_top_notes_str <- "
A slight change from m1 in where the group pre mean for circSD is located. Done to shift probability away from extreme circSD values > 100"

sample_size_notes_str <- "
2 subjs with 252 observations each, 126 per condition. 

9/12 - I am thinking I should simulate varying effects using the actual samples sizes I have. I also think that this shouldnt matter (at least for a model like this). I'll also try with a larger number of subjects.
"

correct_check_notes_str <- "
all good
"

vm_mean_prior_notes_str <- "
Definitely better containment of the group circSD means
"

vm_pred_notes_str <- "
There could be less probability at extreme circSD values. Reducing this would likely be better done by reducing prior group SD.

Also, reducing prior group SD would also reduce extreme max values across subject sets.
"

pMem_mean_prior_notes_str <- "
no changes from m1 here, mean looks fine + uniformative.
"

pMem_pred_notes_str <- "
"

obs_pred_notes_str <- "
No effect predicted in this prior.
"

##############################################
# model fit

fit_qc_notes_str <- "
no divergences, 

good ESS,

good rhat,

good fuzzy plots
"

posterior_notes_str <- "
Main conclusion is that both group mean and subject predicitive dist show reductions in uncertainty, though lots of probability still over zero for both pMem and circSD ES. 

There is a sign of a circSD increase, more data will make that clearer.
"

posterior_pred_notes_str <- "
Predicting data, including group-level SD, shows that there is strong overlap in the pre and post predicitve dists.

Predicting data, ignoring group-level SD and predicting only the average subject, shows more of the trend of an effect.
"

##############################################
# loo

loo_notes_str <- "
All models were fit well. 

WAIC diffs were not very large and had non-neglible SE. Also inconclusive.

waic diff ordering:

## fit_DpMem_null      

## fit_DcircSD_DpMem_null 

## fit_full               

## fit_DcircSD_null

fit_DpMem_null predicted best since it omits the difference parameter on pMem, for which there seems little evidence of an effect.

fit_DcircSD_null fit worst since it omits the parameter that seems to be actually showing a non-zero value. 

fit_full and fit_DcircSD_DpMem_null are in the middle.
"