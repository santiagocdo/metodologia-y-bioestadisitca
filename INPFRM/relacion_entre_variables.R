# # # 1. read the data base  # # ####
datos <- read.csv("ejercicio1.csv")





# # # 2. examine the data base # # ####

# what do you see? do you find something peculiar?

# what is the meaning of the columns? is there any rule? (tip: do not use " " (space))

# visualize in the console all the values for extroversion (bfi10_extraversion)





# # # 3. Descriptive Statistics # # ####

# what are the descriptive statistics for age and sex?

# now do the same for the SCL90 and the BIG5-10items questionnaires.

# do you find any issues? (did you find the NA and the numbers starting with "#")





# # # 4. Create groups from "continuous" variables # # ####

# using the median, create a column with two groups: high and low anxiety   

# create a binary variable called chatAnx that encodes whether a chat was anxious (0) or not (1)





# # # 5. Visualizations # # ####

# install and call a library
if (!require(ggplot2)) {install.packages("ggplot2")}; library(ggplot2)

# visualize the distribution of dependent variable

# visualize the distribution of dependent variable for each condition

# visualize the distribution of dependent variables with a violin plot... then with a boxplot

# obtain the difference between the two x values?

# which one is larger? is that statistically significant? how would you test this? 

# In the classic approach
source("meanDifference.R")

# have you heard about the generalized linear (mixed) model? perhaps a linear regression?
ggplot(datos, aes(x=chatAnx,y=aff_score)) + 
  stat_summary() +
  geom_smooth(method = "lm", se=F) +
  geom_hline(yintercept = mean(datos$aff_score), col="red")
  

# what is the slope between those two means?
m <- lm(aff_score ~ chatAnx, datos)
summary(m)
mean(datos$aff_score)
m <- lm(aff_score ~ chat, datos)
summary(m)


summary(lm(aff_score~ (bfi10_extraversion+bfi10_agreeableness+
             bfi10_conscientiousness+bfi10_neuroticism+bfi10_openness)*chatAnx, datos))
summary(lm(aff_score~(scl90_anxiety+scl90_OCD+scl90_depression+scl90_interSens+
             scl90_psychotic+scl90_paranoidId+scl90_angerHost+scl90_phobic)*chatAnx, datos))

