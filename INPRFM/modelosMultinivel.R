# # # 1. read the data base  # # ####
datos <- read.csv("ejercicio2.csv")

# create a binary coded data for the condition
datos$chatAnx <- ifelse(datos$chat=="Anxious",1,0)
datos$anxiety_group <- ifelse(datos$scl90_anxiety > median(datos$scl90_anxiety), "High (1)", "Low (0)")

