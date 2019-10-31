# color_twoCond_diff

see model_expansion_notes.(html|Rmd) for explanation of model folder structure.

the best way to interact with the set of Rmds script I have left in `common/` is by following the file pattern laid out in the `_template_folder/`.

To do a prior predictive check, model fit, or loo/waic for a given model + data you should use the `render.R` script.

Before you do any of those though, make sure that :
* your data is in the `data/` folder and has a matching format to the template file in there now.
* you have updated the `model_prior.R` file. This is necessary for both prior simulation and model fitting.

* (optional) edit `model_str.R` to change to model math formula, fill in the prior values, or many any initial notes.

Then, open `render.R` and make the sure the paths at the top are correct. From there you can run the entire script or just the portions that you like (e.g only run the prior predictive check)
