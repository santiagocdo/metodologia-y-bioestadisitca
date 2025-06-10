# # # # # normal distribution # # # # #

# Central Limit Theorem
# "the sampling distribution of the mean will always be normally distributed, 
# as long as the sample size is large enough"

# total of samples (is this large enough?)
N_samples <- 5000

# size within each sample
n_wsample <- 100

# create vector with NAs with size N_samples
mean_samples <- rep(NA, N_samples)

# example for one sample with many distributions
sample <- runif(n_wsample,-1,1)
# sample <- rbeta(n_wsample,.5,.5)
# sample <- rexp(n_wsample,1)
# sample <- rgamma(n_wsample,2,2)

# histogram
hist(sample)

# normality test, reject null hypothesis means
shapiro.test(sample)

# built a for loop
for (i in 1:N_samples) {
  # one sample simulation, choose your distribution
  sample <- rbeta(n_wsample,.5,.5)
  # average that sample and save it in mean_samples
  mean_samples[i] <- mean(runif(n_wsample))
}

# histogram
hist(mean_samples, 50)

# normality test
shapiro.test(mean_samples)
