
library(rmarkdown)
library(glue)

common_dir <- "/Users/zaworaca/Desktop/Desktop/zane/color_twoCond_diff/common"
model_dir <- "/Users/zaworaca/Desktop/Desktop/zane/color_twoCond_diff/m6_[color_stm_STIM]"

# load math model str
source(glue("{model_dir}/model_str.R"))

###########################################
# knit math_model markdown file
render(glue("{common_dir}/math_model.Rmd"), 
       output_dir = model_dir,
       params = list(
         formula_str = math_model_str
       ))


###########################################
# knit prior_predictive_check markdown file
prior_check_param_list <- list(
  
  formula_str = math_model_str,
  top_notes_str = prior_check_top_notes_str,
  sample_size_sim_str = sample_size_notes_str,
  correct_check_notes_str = correct_check_notes_str,
  vm_mean_prior_notes_str = vm_mean_prior_notes_str, 
  vm_pred_notes_str = vm_pred_notes_str,
  pMem_mean_prior_notes_str = pMem_mean_prior_notes_str, 
  pMem_pred_notes_str = pMem_pred_notes_str, 
  obs_pred_notes_str = obs_pred_notes_str,
  
  model_dir_str = model_dir,
  common_dir_str = common_dir,
  save_dir_str = glue("{model_dir}/prior_predictive_check") 
  )

render(glue("{common_dir}/prior_predictive_check.Rmd"),
      output_dir = glue("{model_dir}/prior_predictive_check"),
      params = prior_check_param_list)
      

###########################################
# knit sim model fit markdown file

sim_fitting_param_list <- list(
  
  model_dir_str = model_dir,
  common_dir_str = common_dir,
  save_dir_str = glue("{model_dir}/model_fitting_sim") 
)

render(glue("{common_dir}/sim_fit.Rmd"),
       output_dir = glue("{model_dir}/model_fitting_sim"),
       params = sim_fitting_param_list)


###########################################
# knit model_fitting markdown file
model_fitting_param_list <- list(
  
  fit_qc_notes_str = fit_qc_notes_str,
  posterior_notes_str = posterior_notes_str,
  posterior_pred_notes_str = posterior_pred_notes_str,
  
  model_dir_str = model_dir,
  common_dir_str = common_dir,
  save_dir_str = glue("{model_dir}/model_fitting_actual") 
)

render(glue("{common_dir}/model_fitting.Rmd"),
       output_dir = glue("{model_dir}/model_fitting_actual"),
       params = model_fitting_param_list)



###########################################
# knit loo markdown file
loo_param_list <- list(
  
  loo_notes_str = loo_notes_str,
  
  model_dir_str = model_dir,
  common_dir_str = common_dir,
  save_dir_str = glue("{model_dir}/loo") 
)

render(glue("{common_dir}/loo.Rmd"),
       output_dir = glue("{model_dir}/loo"),
       params = loo_param_list)
