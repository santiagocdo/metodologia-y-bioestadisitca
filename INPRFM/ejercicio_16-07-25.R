# Santiago Castiello De Obeso y Ricardo Saracco-Alvarez (16/07/2025).

# # # # General R # # # # ####
# 1. read the csv called "ejercicio_final.csv" and create an object called data.
# Print the first 6 rows of data in your console.
data <- read.csv("ejercicio_final.csv") # WRITE YOUR CODE
head(data) # WRITE YOUR CODE

# this data set represents a RCT, N= 100, with two groups (column: group), each 
# group had 4 measurements (column: time_point). So the data.base has 400 observations
# 4 per participant. It also includes the variables age and sex, and the dependent
# variables y1 and y2. 

# Your task is to analyse this RCT. You will first check the baseline to estimate 
# demographics characteristics, then you will check if there are baseline imbalances
# in the dependent variables. Finally, you will test whether the experimental group 
# (where the intervention takes place) had any effect in any of the dependent variables.

# NOTE: make sure you have installed the packages: ggplot2, and lmerTest. You can 
# install a package in r by running install.packages("nombre_del_paquete").



# # # # Check Baseline: # # # # ####
# 2. filter the baseline (i.e., time_point == 0) and create a new object called: data0
  # WRITE YOUR CODE 

# 3. plot the histogram of age, y1, and y2
  # WRITE YOUR CODE 
  # WRITE YOUR CODE 
  # WRITE YOUR CODE 

# 4. are y1 and y2 normally distributed? (will you use Shapiro-Wilk or Kolmogorov-Smirnov?)
  # WRITE YOUR CODE 
  # WRITE YOUR CODE 

# 5. calculate the mean, standard deviation, and range of the variables: age, y1, and y2
  # WRITE YOUR CODE 
  # WRITE YOUR CODE 
  # WRITE YOUR CODE 

# 6. calculate the sex frequencies and proportion of sex
  # WRITE YOUR CODE 
  # WRITE YOUR CODE 

# 7. now please calculate the mean, sd, and range, as well as the sex frequencies 
# and proportions per each group (Experimental and Control). You may need to split
# data0 into two, one per group
  # WRITE YOUR CODE 
  # WRITE YOUR CODE 
  # WRITE YOUR CODE 
  # WRITE YOUR CODE 
  # WRITE YOUR CODE
  # WRITE YOUR CODE
  # WRITE YOUR CODE
  # WRITE YOUR CODE

# 7. using the library ggplot2 visualize the dependent variables y1 and y2 as a function of group
# are there any clear visual differences? please add also a boxplot
library(ggplot2)
# WRITE YOUR CODE 
# WRITE YOUR CODE 

# 7. test if there is group differences for y1 and y2. Use a simple linear model.
# Then test whether residuals of the linear model are normally distributed.
  # WRITE YOUR CODE 
  # WRITE YOUR CODE 
  # WRITE YOUR CODE 
  # WRITE YOUR CODE 

# 8. interpret the results of the models above. Is there any difference in y1 or 
# y2 between the groups? what is the mean difference for y1 and y2?
  # WRITE YOUR INTERPRETATION


# # # # Check the effect of the intervention # # # # ####
# 9. now you should use the data called "data", because it contains all the 
# time_point per participant (not only baseline where time_point==0). You will 
# first visualize the dependent variables (y1 and y2) as a function of time. 
# Add a regression line to your plots.
  # WRITE YOUR CODE 
  # WRITE YOUR CODE 

# 10. is there any effect between time_point and y1 or y2? test this with a 
# linear mixed model. You should be able to say why using a linear mixed model, 
# instead of a simple linear model.
library(lmerTest)
  # WRITE YOUR CODE 
  # WRITE YOUR CODE 

# 11. visualize the effect of the intervention by adding a different color for each 
# group. So plot dependent variables in y axis, time in x, and group with color. 
# These new plots should also include a regression line. Add a plot title and change 
# the x and y axis titles for "y=Variable Dependiente" and x="Tiempo"
  # WRITE YOUR CODE 
  # WRITE YOUR CODE 

# 12. estimate the effect of the intervention (group) in the dependent variables
# as function of time Thus, run a linear mixed model predicting each dependent 
# variable (y1, and y2) with the # regressors: time_point, group, and their interaction.
  # WRITE YOUR CODE 
  # WRITE YOUR CODE 

# 13. control your analysis by age and sex. 
  # WRITE YOUR CODE 
  # WRITE YOUR CODE 

# 14. What can we learn from the previous analysis (13)? does any effect change by 
# adding sex and age? (particularly does the interaction effect changes?)
  # WRITE YOUR RESPONSE

# 15. Model interpretation. Is there any effect on the intervention in y1 and y2 
# (11, 12, and 13)? If so, what is the effect difference between groups? 
# (i.e., difference in slopes)
  # WRITE YOUR INTERPRETATION