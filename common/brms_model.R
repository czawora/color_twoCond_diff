
require(brms)


log_lik_vm_uniform_mix <- function(i, draws) {
  
  b <- draws$dpars$b
  a <- draws$dpars$a
  theta <- draws$dpars$theta[, i]
  circSD <- draws$dpars$circSD[, i]
  mu <- draws$dpars$mu[, i]
  
  y <- draws$data$Y[i]
  
  vm_uniform_mix_lpdf(y, mu, circSD, theta, a, b)
}
 
#definition
vm_uniform_mix <- custom_family(
  "vm_uniform_mix", 
  dpars = c("mu", "circSD", "theta", "a", "b"),
  links = c("identity", "log", "logit", "identity", "identity"), 
  lb = c(NA, 0, 0, NA, NA),
  ub = c(NA, NA, 1, NA, NA),
  type = "real", # response type
  log_lik = log_lik_vm_uniform_mix
)

# fill in functions needed to density evaluation and rng
stan_funs <- "

  real deg2rad( real d){
    return(d * (pi()/180));
  }

  real sd2k( real sd_input) {
  
    //sd_input needs to be radians

    //original matlab code
    // R <- exp(-S.^2/2);
    // K = 1./(R.^3 - 4 * R.^2 + 3 * R);
    // K(R < 0.85) = -0.4 + 1.39 * R(R < 0.85) + 0.43./(1 - R(R < 0.85));
    // K(R < 0.53) = 2 * R(R < 0.53) + R(R < 0.53).^3 + (5 * R(R < 0.53).^5)/6;

    real R;
    real K;

    R = exp(-(sd_input^2)/2);
    K = 1/((R^3) - (4 * R^2) + (3*R));
  
    if(R < 0.85){
      K = -0.4 + (1.39 * R) + (0.43/(1-R));
    }
  
    if(R < 0.53){
      K = (2 * R) + R^3 + (5 * R^5)/6;
    }

    return(K);
  }

  real vm_uniform_mix_lpdf(real y, real mu, real circSD, real theta, real a, real b) {
    
   
   real kappa = sd2k(deg2rad(circSD));


   //* for kappa > 100 the normal approximation is used
   //* for reasons of numerial stability

    if (kappa > 100){

    return log_mix( theta ,
                    normal_lpdf(y | mu, sqrt(1/kappa)),
                    uniform_lpdf(y | a, b));

    } else {

    return log_mix( theta ,
                    von_mises_lpdf(y | mu, kappa),
                    uniform_lpdf(y | a, b));
    }
  }

  real vm_uniform_mix_rng(real mu, real circSD, real theta, real a, real b) {
    
    int flip = bernoulli_rng(theta);
    
    real phi;

    if (flip == 1){
      phi = von_mises_rng(mu, sd2k(deg2rad(circSD)));
    }else{
      phi = uniform_rng(a, b);
    }

    return(phi);

  }
"
stanvars <- stanvar(scode = stan_funs, block = "functions")

# several models

# full model
bform_full <- 
  bf(error ~ 0, #formula for first parameter mu
     circSD ~ 0 + intercept + stimulation + (1 + stimulation || subj),
     theta ~ 0 + intercept + stimulation + (1 + stimulation || subj), 
     a = -pi, 
     b = pi,
     family = vm_uniform_mix)

# full model w/ setting group level stimulation on circSD to zero
bform_DcircSD_null <- 
  bf(error ~ 0, #formula for first parameter mu
     circSD ~ 0 + intercept + (1 + stimulation || subj),
     theta ~ 0 + intercept + stimulation + (1 + stimulation || subj), 
     a = -pi, 
     b = pi,
     family = vm_uniform_mix)

# full model w/ setting group level stimulation on pMem to zero
bform_DpMem_null <-
  bf(error ~ 0, #formula for first parameter mu
     circSD ~ 0 + intercept + stimulation + (1 + stimulation || subj),
     theta ~ 0 + intercept + (1 + stimulation || subj), 
     a = -pi, 
     b = pi,
     family = vm_uniform_mix)
  
# full model w/ setting group level stimulation on both circSD and pMem to zero
bform_DcircSD_DpMem_null <- 
  bf(error ~ 0, #formula for first parameter mu
     circSD ~ 0 + intercept + (1 + stimulation || subj),
     theta ~ 0 + intercept + (1 + stimulation || subj), 
     a = -pi, 
     b = pi,
     family = vm_uniform_mix)
  


