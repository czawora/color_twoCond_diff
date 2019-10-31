

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
circ\\_sd_i &= exp(\\alpha_{0,SUBJ[i]} + \\alpha_{\\Delta,SUBJ[i]} * postCond) ~~ \\mathrm{-log~link~on~sd-} \\\\
pMem_i &= inv\\_logit(\\beta_{0,SUBJ[i]} + \\beta_{\\Delta,SUBJ[i]} * postCond) ~~ \\mathrm{-logit~link~on~pMem-} \\\\
\\\\
\\mathrm{-priors:~all~independent-}\\\\
\\alpha_{0,SUBJ[...]} &\\sim Normal(mu\\_\\alpha_0, sigma\\_\\alpha_0) \\\\
\\alpha_{\\Delta,SUBJ[...]} &\\sim Normal(mu\\_\\alpha_{\\Delta}, sigma\\_\\alpha_{\\Delta}) \\\\
\\beta_{0,SUBJ[...]} &\\sim Normal(mu\\_\\beta_0, sigma\\_\\beta_0) \\\\
\\beta_{\\Delta,SUBJ[...]} &\\sim Normal(mu\\_\\beta_{\\Delta}, sigma\\_\\beta_{\\Delta}) \\\\
\\\\
mu\\_\\alpha_0 &\\sim Normal(4, 0.5)\\\\
sigma\\_\\alpha_0 &\\sim Normal^+(0, 0.5) \\\\
mu\\_\\alpha_{\\Delta} &\\sim Normal(0, 0.5)\\\\
sigma\\_\\alpha_{\\Delta} &\\sim Normal^+(0, 0.5)\\\\
mu\\_\\beta_0 &\\sim Normal(0, 1.5)\\\\
sigma\\_\\beta_0 &\\sim Normal^+(0, 1.5)\\\\
mu\\_\\beta_{\\Delta} &\\sim Normal(0, 1)\\\\
sigma\\_\\beta_{\\Delta} &\\sim Normal^+(0, 1)\\\\
\\end{aligned}
$$
"


##############################################
# prior predictive check 


prior_check_top_notes_str <- "
I'm starting this prior check with the work I've already done in the sandbox. 
In those scripts I already got a sense of what weakly informative priors for my starting model might be. 
In those files, I only did a visual inspection of the prior predictive distribution, not neccesarily including any summary statistics. 
I also did not do any sort of checks based on the sample size of the small design I have."

sample_size_notes_str <- "
2 subjs with 252 observations each, 126 per condition. 

9/12 - I am thinking I should simulate varying effects using the actual samples sizes I have. I also think that this shouldnt matter (at least for a model like this). I'll also try with a larger number of subjects.
"

correct_check_notes_str <- "all good here."

vm_mean_prior_notes_str <- "
circSD group mean prior (pre + post) - too wide, too much probability stretching past 100
circSD group mean ES - all wider than need be
"
vm_pred_notes_str <- "
way too much probability given to seeing subjects with extreme circSD and extreme ES

measured SD of subjects circSD is also way too large

the same is true of max and min circSD, ES across sim subjects
"

pMem_mean_prior_notes_str <- "
fairly standard prior on the pMem group mean, totally uninformative.
"

pMem_pred_notes_str <- "
prior predictive dists for pre, post and ES dont look bad.
though, max + min plots could be less extreme.
"

obs_pred_notes_str <- "
no much gleaned from these prior plots, except that the prior expects no effect and the post condition has larger variance of probability.
"