# mas informacion https://statistics.berkeley.edu/computing/r-t-tests
meanDifference <- function(sample1, sample2, paired){
  
  # Type I error probability
  alpha <- 0.05 
  
  norm1 <- shapiro.test(sample1) # Shapiro-Wilk normality test
  norm2 <- shapiro.test(sample2) # Shapiro-Wilk normality test
  
  homoce <- var.test(sample1,sample2) # F test to compare two variances
  
  if (homoce$p.value > alpha) {var_equal = 1} else {var_equal = 0} 
  # there is a difference in t test depending homocedasticity. 
  # For var_equal: 1 = Two Sample t-test; 0 = Welch Two Sample t-test
  
  if (norm1$p.value > alpha  & norm2$p.value > alpha) {
    test <- t.test(sample1,sample2, paired = paired, var.equal = var_equal)
  } else {
    test <- wilcox.test(sample1,sample2, paired = paired)
  }
  return(test)
}