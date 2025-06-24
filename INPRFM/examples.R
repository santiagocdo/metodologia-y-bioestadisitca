
x <- -5:5
y <- 0 + 0 * x
a<-ggplot(data.frame(x,y),aes(x=x,y=y)) + geom_line() + labs(title = "y=f(0*x)") +
  scale_x_continuous(breaks = c(-4,-2,0,2,4), limits = c(-5,5)) +
  scale_y_continuous(breaks = c(-4,-2,0,2,4), limits = c(-5,5)) 
y <- 1 * x 
b<-ggplot(data.frame(x,y),aes(x=x,y=y)) + geom_line() + labs(title = "y=f(x)") +
  scale_x_continuous(breaks = c(-4,-2,0,2,4), limits = c(-5,5)) +
  scale_y_continuous(breaks = c(-4,-2,0,2,4), limits = c(-5,5)) 
y <- 2 * x 
c<-ggplot(data.frame(x,y),aes(x=x,y=y)) + geom_line() + labs(title = "y=f(2x)") +
  scale_x_continuous(breaks = c(-4,-2,0,2,4), limits = c(-5,5)) +
  scale_y_continuous(breaks = c(-4,-2,0,2,4), limits = c(-5,5)) 
y <- -2 * x 
d<-ggplot(data.frame(x,y),aes(x=x,y=y)) + geom_line() + labs(title = "y=f(-2x)") +
  scale_x_continuous(breaks = c(-4,-2,0,2,4), limits = c(-5,5)) +
  scale_y_continuous(breaks = c(-4,-2,0,2,4), limits = c(-5,5)) 
ggpubr::ggarrange(a,b,c,d)


x <- -5:5
y <- 1 + 0 * x
a<-ggplot(data.frame(x,y),aes(x=x,y=y)) + geom_line() + labs(title = "y=f(1+0*x)") +
  scale_x_continuous(breaks = c(-4,-2,0,2,4), limits = c(-5,5)) +
  scale_y_continuous(breaks = c(-4,-2,0,2,4), limits = c(-5,5)) 
y <- -1 + 0 * x 
b<-ggplot(data.frame(x,y),aes(x=x,y=y)) + geom_line() + labs(title = "y=f(-1+0*x)") +
  scale_x_continuous(breaks = c(-4,-2,0,2,4), limits = c(-5,5)) +
  scale_y_continuous(breaks = c(-4,-2,0,2,4), limits = c(-5,5)) 
y <- -2 + 2 * x 
c<-ggplot(data.frame(x,y),aes(x=x,y=y)) + geom_line() + labs(title = "y=f(-2+2x)") +
  scale_x_continuous(breaks = c(-4,-2,0,2,4), limits = c(-5,5)) +
  scale_y_continuous(breaks = c(-4,-2,0,2,4), limits = c(-5,5))
y <- 2 - 2 * x 
d<-ggplot(data.frame(x,y),aes(x=x,y=y)) + geom_line() + labs(title = "y=f(2-2*x)") +
  scale_x_continuous(breaks = c(-4,-2,0,2,4), limits = c(-5,5)) +
  scale_y_continuous(breaks = c(-4,-2,0,2,4), limits = c(-5,5)) 
ggpubr::ggarrange(a,b,c,d)



# # # 4. Create groups from "continuous" variables # # ####

# using the median, create a column with two groups: high and low anxiety   

# create a binary variable called chatAnx that encodes whether a chat was anxious (0) or not (1)
datos$chatAnx <- ifelse(datos$chat=="Anxious",1,0)






#~~~~~# RESUELTO #~~~~~#
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
ggplot(datos, aes(x=chat,y=aff_score)) + geom_boxplot()

# you can save one of the above plots (e.g., violin) into an object called p
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

# which one is larger? is that statistically significant? how would you test this? 

# In the classic approach. What is the classic approach?
source("meanDifference.R")
meanDifference(anx_aff_score, non_aff_score, T)

# have you heard about the generalized linear (mixed) model? perhaps a linear regression?
model <- lm(aff_score ~ chat, datos)
# see the summary
summary(model)

# what is the slope between those two means?

# an alternative approach: model comparisons

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
hist(m1$residuals)
shapiro.test(m1$residuals)





p <- ggplot(datos, aes(x=chatAnx,y=aff_score)) + 
  stat_summary() + 
  scale_x_continuous(breaks = c(0,1), 
                     labels = c("Anxious","Non-Anxious"),
                     limits = c(-.3,1.3))
m0 <- ggplot(datos, aes(x=chatAnx,y=aff_score)) + 
  stat_summary() + 
  scale_x_continuous(breaks = c(0,1), 
                     labels = c("Anxious","Non-Anxious"),
                     limits = c(-.3,1.3)) +
  geom_hline(yintercept = mean(datos$aff_score), col="red", size=1.2)
m1 <- ggplot(datos, aes(x=chatAnx,y=aff_score)) + 
  stat_summary() + 
  scale_x_continuous(breaks = c(0,1), 
                     labels = c("Anxious","Non-Anxious"),
                     limits = c(-.3,1.3)) +
  geom_smooth(method = "lm", se=F, col="red", size=1.2) 

ggpubr::ggarrange(p,m0,m1, ncol=3)



p <- ggplot(datos, aes(x=chatAnx,y=aff_score)) + 
  stat_summary() + labs(x="Chatbot condition") +
  scale_x_continuous(breaks = c(0,1), 
                     labels = c("Non-Anxious (0)","Anxious (1)"),
                     limits = c(-.3,1.3))
m0 <- ggplot(datos, aes(x=chatAnx,y=aff_score)) + 
  stat_summary() + labs(x="Chatbot condition") +
  scale_x_continuous(breaks = c(0,1), 
                     labels = c("Non-Anxious (0)","Anxious (1)"),
                     limits = c(-.3,1.3)) +
  geom_hline(yintercept = mean(datos$aff_score), col="red", size=1.2)
m1 <- ggplot(datos, aes(x=chatAnx,y=aff_score)) + 
  geom_smooth(method = "lm", se=F, col="red", size=1.2) +
  stat_summary() + labs(x="Chatbot condition") +
  scale_x_continuous(breaks = c(0,1),
                     labels = c("Non-Anxious (0)","Anxious (1)"),
                     limits = c(-.3,1.3))
 
ggpubr::ggarrange(p,m0,m1, ncol=3)


datos$anxiety_group <- ifelse(datos$scl90_anxiety > median(datos$scl90_anxiety), "High (1)", "Low (0)")

(p1 <- ggplot(datos, aes(x=chatAnx,y=aff_score)) +
    labs(x="Chatbot condition") +
    geom_smooth(method = "lm", se=F, col="black") +
    stat_summary() + coord_cartesian(ylim = c(-1,1)) +
    scale_x_continuous(breaks = c(0,1),
                       labels = c("Non-Anxious (0)","Anxious (1)"),
                       limits = c(-.35,1.3)))
(p2 <- ggplot(datos, aes(x=ifelse(anxiety_group=="High (1)",1,0),y=aff_score,col=anxiety_group)) +
    labs(x="anxiety_group") +
    geom_smooth(method = "lm", se=F, col="black") +
    stat_summary() + coord_cartesian(ylim = c(-1,1)) +
    scale_x_continuous(breaks = c(0,1),
                       labels = c("Low (0)","High (1)"),
                       limits = c(-.3,1.3)) +
    theme(legend.position = c(.35,.15)))
(p3 <- ggplot(datos, aes(x=chatAnx,y=aff_score,col=anxiety_group)) + 
    labs(x="Chatbot condition") +
    geom_smooth(method = "lm", se=F) +
    stat_summary() + coord_cartesian(ylim = c(-1,1)) +
    scale_x_continuous(breaks = c(0,1), 
                       labels = c("Non-Anxious (0)","Anxious (1)"),
                       limits = c(-.3,1.3)) +
    theme(legend.position = c(.35,.15)))
ggarrange(p1, p2, p3, ncol=3)

datos$anxiety_group <- ifelse(datos$anxiety_group == "High (1)", 1, 0)

summary(lm(aff_score ~ 1, datos))
summary(lm(aff_score ~ chatAnx, datos))
summary(lm(aff_score ~ anxiety_group, datos))
summary(lm(aff_score ~ anxiety_group * chatAnx, datos))





# # # 1. read the data base  # # ####
datos <- read.csv("ejercicio2.csv")
# create a binary coded data for the condition
datos$chatAnx <- ifelse(datos$chat=="Anxious",1,0)
datos$anxiety_group <- ifelse(datos$scl90_anxiety > median(datos$scl90_anxiety), "High (1)", "Low (0)")
# visualize
ggplot(datos, aes(x=chatAnx,y=aff_score,col=as.factor(anxiety_group))) + 
  stat_summary() + geom_smooth()

model <- lm(aff_score ~ chatAnx, datos)

hist(model$residuals)
sum(model$residuals)

ks.test(model$residuals[!duplicated(model$residuals)],"pnorm")

library(lmerTest)
library(lme4)
model <- lmer(aff_score ~ chatAnx + (chatAnx|participant_id), datos)
summary(model)

# as.data.frame(ranef(model)$participant)
datos$predicted_outcome <- predict(model)

pR2 <- ggplot(datos, aes(x = chatAnx, y = aff_score)) +
  geom_line(aes(y = predicted_outcome, group = participant_id), 
            size = .3, alpha = .5) + # Model predictions
  stat_summary(fun.data = "mean_cl_boot") + #geom_point(alpha = 0.6) +
  geom_smooth(method = "lm", se=F, col="black") +
  labs(title = "Random Effect", 
       x = "Chatbot condition ", y = "Affiliation Score") +
  scale_x_continuous(breaks = c(0,1), 
                     labels = c("Non-Anxious (0)","Anxious (1)"),
                     limits = c(-.3,1.3)) + 
  coord_cartesian(ylim = c(-2,2)) +
  theme_classic()

library(ggpubr)
ggarrange(pF, pR, pR2, ncol=3)
