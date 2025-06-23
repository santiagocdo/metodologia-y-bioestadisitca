# # # 1. read the data base  # # ####
datos <- read.csv("ejercicio1.csv")

# create a binary coded data for the condition
datos$chatAnx <- ifelse(datos$chat=="Anxious",1,0)

# create a group based on the median of the anxiety score
datos$anxiety_group <- ifelse(datos$scl90_anxiety > median(datos$scl90_anxiety), 1, 0)


library(ggplot2)

ggplot(datos, aes(x=anxiety_group, y=aff_score, col=chat)) + 
  stat_summary() +
  scale_x_continuous(breaks = c(0, 1), labels = c("Non-Anxious (0)","Anxious (1)"))


ggplot(datos, aes(x=scl90_anxiety, y=aff_score, col=chat)) + 
  geom_point(alpha=.2) +
  geom_smooth(method="lm", se=FALSE) +
  theme_minimal()

model <- lm(aff_score ~ scl90_anxiety + chat + scl90_anxiety*chat, datos)
summary(model)
