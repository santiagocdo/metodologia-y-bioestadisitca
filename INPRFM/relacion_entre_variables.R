# # # 1. read the data base  # # ####
datos <- read.csv("ejercicio1.csv")





# # # 2. examine the data base # # ####

# what do you see? do you find something peculiar?
View(datos)
# what is the meaning of the columns? is there any rule? (tip: do not use " " (space))
class(datos)
# visualize in the console all the values for extroversion (bfi10_extraversion)
hist(datos$bfi10_extraversion)






# # # 3. Descriptive Statistics # # ####
# filrar la base de datos para tener un participante por fila
datos2 <- datos[duplicated(datos$participant_id),]

# what are the descriptive statistics for age and sex?
table(datos2$sex)
round((table(datos2$sex)/nrow(datos2))*100,2)

mean(datos2$age)
sd(datos2$age)
range(datos2$age)
median(datos2$age)

# now do the same for the SCL90 and the BIG5-10items questionnaires.
hist(datos2$scl90_anxiety)
hist(datos2$bfi10_neuroticism)

# do you find any issues? (did you find the NA and the numbers starting with "#")
hist(datos2$scl90_depression)
mean(datos2$scl90_depression)
sd(datos2$scl90_depression)
range(datos2$scl90_depression)

# que ocurre?
mean(datos$scl90_depression, na.rm = T)



# # # 4. Create groups from "continuous" variables # # ####

# using the median, create a column with two groups: high and low anxiety   
datos2$anxiety_group <- ifelse(datos2$scl90_anxiety > median(datos2$scl90_anxiety), "high", "low")
datos$anxiety_group <- ifelse(datos$scl90_anxiety > median(datos$scl90_anxiety), 1, 0)

# create a binary variable called chatAnx that encodes whether a chat was anxious (0) or not (1)
datos$chatAnx <- ifelse(datos$chat=="Anxious",1,0)






# # # 5. Visualizations # # ####

# install and call a library
if (!require(ggplot2)) {install.packages("ggplot2")}; library(ggplot2)

# visualize the distribution of dependent variable
ggplot(datos, aes(x=aff_score)) + geom_histogram()

# change the bin size
ggplot(datos, aes(x=aff_score)) + geom_histogram(bins = 10)

# what happens if you plot it in the y-axis?
ggplot(datos, aes(y=aff_score)) + geom_histogram(bins = 10)

# can you add sex as bar with a different colour?
ggplot(datos, aes(x=aff_score,fill=sex)) + geom_histogram(bins = 10)

# visualize the distribution of dependent variable for each condition
ggplot(datos, aes(x=aff_score,fill=sex)) + geom_histogram(bins = 10) +
  facet_grid(.~chat)

# visualize mean of the dependent variable for each condition
ggplot(datos, aes(x=chat,y=aff_score)) + stat_summary()

# visualize the distribution of dependent variables with a violin plot... then with a boxplot
ggplot(datos, aes(x=chat,y=aff_score)) + geom_violin()
ggplot(datos, aes(x=chat,y=aff_score)) + geom_boxplot()# you can save one of the above plots (e.g., violin) into an object called p
p <- ggplot(datos, aes(x=chat,y=aff_score)) + geom_violin()

# you can also add these features or layers in the same plot
p + stat_summary(fun.data = "mean_cl_boot")

# then save it again into p
p <- p + stat_summary(fun.data = "mean_cl_boot")
p

# can you change the style or theme of the plot? 
p + theme_dark()







# # # 6. Inferential Statistics # # ####

# is a distribution normally distributed?
ggplot(datos, aes(x=aff_score)) + geom_histogram()

# how can we test it?
shapiro.test(datos$aff_score)

# obtain the difference between the two x values?
anx_aff_score <- datos$aff_score[datos$chat=="Anxious"]
non_aff_score <- datos$aff_score[datos$chat=="Non-Anxious"]
mean(anx_aff_score)
mean(non_aff_score)
mean(non_aff_score) - mean(anx_aff_score)

# obtain the difference between the two x values?

# which one is larger? is that statistically significant? how would you test this? 

# In the classic approach. What is the classic approach?
source("meanDifference.R")
meanDifference(anx_aff_score, non_aff_score, T)

# have you heard about the generalized linear (mixed) model? perhaps a linear regression?
model <- lm(aff_score ~ chat, datos)
# see the summary
summary(model)

# what is the slope between those two means?

# null model
m0 <- lm(aff_score ~ 1, datos)

# my model
m1 <- lm(aff_score ~ chat, datos)

# comparing two models with a likelihood ratio test
anova(m0, m1)

# other alternatives to compare models
# log-likelihood or model evidence (higher=better)
logLik(m0)
logLik(m1)
# Bayesian Information Criterion (lower=better)
BIC(m0,m1)
# Akaike Information Criterion (lower=better)
AIC(m0,m1)

# can we use aff_score in a GLM (linear regression) if it is not normally distributed?
hist(datos$aff_score)
shapiro.test(datos$aff_score)

# what are the assumptions of this model?

# 1 normal distributed residuals
hist(m1$residuals)
shapiro.test(m1$residuals)

# 2 independence between errors and regressors (x)
t.test(m1$residuals~datos$chatAnx)
