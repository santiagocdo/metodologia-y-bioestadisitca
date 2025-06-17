# # # 1. read the data base  # # ####
datos <- read.csv("ejercicio1.csv")

# create a binary coded data for the condition
datos$chatAnx <- ifelse(datos$chat=="Anxious",1,0)

# create a group based on the median of the anxiety score
datos$anxiety_group <- ifelse(datos$scl90_anxiety > median(datos$scl90_anxiety), 1, 0)

