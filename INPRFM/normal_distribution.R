# # # # # normal distribution # # # # #

# Central Limit Theorem
# "the sampling distribution of the mean will always be normally distributed, 
# as long as the sample size is large enough"

# total of samples (is this large enough?)
N_samples <- 5000

# size within each sample
n_wsample <- 30

# create vector with NAs with size N_samples
mean_samples <- rep(NA, N_samples)

# example for one sample with many distributions
sample <- rnorm(n_wsample)
# sample <- runif(n_wsample,-1,1)
# sample <- rbeta(n_wsample,.5,.5)
# sample <- rexp(n_wsample,1)
# sample <- rgamma(n_wsample,2,2)
# sample <- rpois(n_wsample, lambda=1)

# histogram
hist(sample)

# built a for loop
for (i in 1:N_samples) {
  # one sample simulation, choose your distribution
  sample <- rnorm(n_wsample,.5,.5)
  # average that sample and save it in mean_samples
  mean_samples[i] <- mean(sample)
}

# histogram
hist(mean_samples, 20)

# normality test
# Shapiro-Wilk Test: Preferred for small to medium sample sizes when testing for normality is required.
# Kolmogorov-Smirnov Test: Useful for larger samples or comparing distributions
if (length(mean_samples) < 50) { # this is a bit arbitrary
  # Null Hypothesis (H0): The data is normally distributed.
  shapiro.test(mean_samples)
  # p < .05 significantly different from normal
  
} else {
  # Null Hypothesis (H0): The sample data comes from the reference distribution (e.g., normal distribution).
  ks.test(mean_samples, "pnorm", mean(mean_samples), sd(mean_samples))
  # p < .05 significantly different from normal
}


