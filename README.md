# color_twoCond_diff

## Repo summary

The analyses contained in this repository were performed for a collaborator in an NIH study examining the effect of disruptions of the medial temporal lobe on working memory. See `manuscript.pdf` for a fuller description of the study and experimental set up.

#### Data Generation

Patients were shown several small colored squares on a computer screen. After a moment the squares disappeared with only one empty square outline remaining. A color wheel was then presented to the patient and they were asked to identify the color on the wheel that previously occupied the empty square using a dial. The errors of the patients' color guesses were recorded for each trial. Patients were tested pre and post treatment. The analyses contained in this repository are purely of the behavioral test data and do not include any analysis of patient EEG recordings.

#### Data Quality

Data collection went smoothly and no data was missing and no impossible values were present in the dataset. Data quality checks can be seen in `m*/data_summary` folders.

#### Analysis goal

To determine if treatment of the medial temporal lobe, either electrical or surgical, had any effect on working memory performance. With only two patients worth of data at the time of analysis, a second goal was the production of reusable modeling code for use with an eventual larger pool of patients.

#### Modelling process

The models used in this analysis are Bayesian and modeling was performed with a Bayesian [workflow](https://arxiv.org/pdf/2011.01808.pdf) in mind.

Specifically, Bayesian hierarchical mixture models are used with this data. Through an iterative process, models were fit and refined, mostly through the adjustment of priors to exclude extreme values prior to model fitting. The progression of model development is documented in `model_expansion_notes.*` files. Models were specified and fit using the [`brms`](https://paul-buerkner.github.io/brms/) R package.

A full mathematical description of each model can be found in each model folders math model file (`m*/math_model.html` or `model_stash/m*/math_model.html`).

The trial-level likelihood models are a mixture of a uniform distribution and a circular von Mises distribution. The uniform distribution theoretically represents pure guess responses in which patient had mostly forgotten the color whereas the von Mises distribution represents errors of guesses based off a memory of the missing color. With the von Mises distribution location parameter set to 0, there were two parameters in the likelihood model to estimate, the mixture probability and the von Mises dispersion parameter, which was transformed and modeled as a circular standard deviation.

Each likelihood parameter was, in turn, modeled linearly as a function of two parameters, a patient-level intercept and a patient-level treatment effect. Because the circular standard deviation parameter must be positive, it was modeled with an exponential link function. The mixture parameter is bounded between 0 and 1 and was modeled with a logit link function. Lastly, the four patient-level parameters were modeled as distributed according to four independent population-level normal distributions. The population level distribution parameters were then given weakly informative priors to contain probability in areas of reasonable values.

Model iteration proceeded with a prior predictive check, posterior fit and summary. In the case of this analysis, the overall model structure remained the same and model priors were adjusted to reasonable values. Each model iteration also includes a leave-one-out (loo) cross validation that compares nested models to examine the importance of the treatment effect parameter.

#### Results

The results of the analysis were not conclusive but did suggest an increase in guess error after treatment. This is most visible when inspecting the posterior predictive distributions after model fit (can be found at the bottom of `m*/model_fitting_actual/model_fit.html`). The loo comparisons for each model were not indicative of any strong difference between models with and without the treatment effect parameter.

## Notes for use

see model_expansion_notes.(html\|Rmd) for explanation of model folder structure.

the best way to interact with the set of Rmds script I have left in `common/` is by following the file pattern laid out in the `_template_folder/`.

To do a prior predictive check, model fit, or loo/waic for a given model + data you should use the `render.R` script.

Before you do any of those though, make sure that : \* your data is in the `data/` folder and has a matching format to the template file in there now. \* you have updated the `model_prior.R` file. This is necessary for both prior simulation and model fitting.

-   (optional) edit `model_str.R` to change to model math formula, fill in the prior values, or many any initial notes.

Then, open `render.R` and make the sure the paths at the top are correct. From there you can run the entire script or just the portions that you like (e.g only run the prior predictive check)
