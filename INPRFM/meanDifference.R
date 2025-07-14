# mas informacion https://statistics.berkeley.edu/computing/r-t-tests
meanDifference <- function(sample1, sample2, paired = F){
  # set type-I error
  alpha <- .05 
  
  # test normality
  if (length(c(sample1,sample2))/2 > 50) {
    norm1 <- ks.test(sample1, "pnorm") # Kolmogorov-Smirnov normality test
    norm2 <- ks.test(sample2, "pnorm") # Kolmogorov-Smirnov normality test
  } else {
    norm1 <- shapiro.test(sample1) # Shapiro-Wilk normality test
    norm2 <- shapiro.test(sample2) # Shapiro-Wilk normality test
  }
  
  # parametric or non-parametric mean differences
  if (norm1$p.value > alpha  & norm2$p.value > alpha) {
    # test homocedasticity
    homoce <- var.test(sample1,sample2) # F test to compare two variances
    
    if (homoce$p.value > alpha) {var_equal = 1} else {var_equal = 0} 
    # there is a difference in t test depending homocedasticity. 
    # For var_equal: 1 = Two Sample t-test; 0 = Welch Two Sample t-test
    test <- t.test(sample1, sample2, paired = paired, var.equal = var_equal)
  } else {
    test <- wilcox.test(sample1, sample2, paired = paired)
  }
  return(test)
}
