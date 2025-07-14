# NOTA general del script.

# # # 1. read the data base  # # ####
datos <- read.csv("ejercicio2.csv")


# # # 2. Adjust Data to what we need  # # ####
# create a binary coded data for the condition
datos$chatAnx <- ifelse(datos$chat == "Anxious", 1, 0)
datos$anxiety_group <- ifelse(datos$scl90_anxiety > median(datos$scl90_anxiety), "High (1)", "Low (0)")

table(datos$anxiety_group)

# binarizing affiliation
datos$aff_binary <- ifelse(datos$aff_score > 0, 1, 0)

table(datos$anxiety_group, datos$aff_binary)

# # # 3. Run Logistic Mixed models  # # ####
library(lmerTest)

# to write a model in multilevel notation use (1|cluster)
m <- glmer(aff_binary ~ anxiety_group + (1|participant_id), family = "binomial", datos)
# observe the summary of the model m
summary(m)
# obtain confidence intervals from the model m
confint(m)
# you can estimate an ODDs ratio from the estimates of a logistic regression
# 0.1443, -0.4390114, 0.7328556
exp(c(0.1443,-0.4390114,0.7328556))

ggplot(datos, aes(x=chatAnx, y=aff_binary)) + stat_summary()






datos <- read.csv("ejercicio1.csv")
datos$depression <- ifelse(datos$scl90_depression > median(datos$scl90_depression),1,0)

m <- glm(depression ~ scl90_anxiety, family = binomial, datos)
summary(m)
confint(m)

exp(c(2.1182))
