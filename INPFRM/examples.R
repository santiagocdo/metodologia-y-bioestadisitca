
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




# # # 5. Visualizations # # ####

# install and call a library
if (!require(ggplot2)) {install.packages("ggplot2")}; library(ggplot2)

# visualize the distribution of dependent variable
ggplot(data, aes(x=aff_score)) + 
  geom_histogram()

# visualize the distribution of dependent variable for each condition
ggplot(data, aes(x=aff_score)) + 
  geom_histogram(binwidth=1, color="black", fill="white") +
  facet_grid(chat~.)

# visualize the distribution of dependent variables with a violin plot... then with a boxplot
p <- ggplot(data, aes(x=chat,y=aff_score))
p + geom_violin()
p + geom_boxplot()

# obtain the difference between the two x values?
mean(datos$aff_score[datos$chatAnx==1])-
  mean(datos$aff_score[datos$chatAnx==0])

# which one is larger? is that statistically significant? how would you test this? 

# In the classic approach
source("meanDifference.R")
meanDifference(datos$aff_score[datos$chat=="Anxious"], 
               datos$aff_score[datos$chat=="Non-Anxious"], 
               paired = T)

ggplot(datos, aes(x=chatAnx,y=aff_score)) + 
  stat_summary()

# have you heard about the generalized linear (mixed) model? perhaps a linear regression?
ggplot(datos, aes(x=chatAnx,y=aff_score)) + 
  stat_summary() +
  geom_smooth(method = "lm") 
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

