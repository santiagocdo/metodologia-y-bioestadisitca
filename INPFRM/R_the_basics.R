# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # ####
# # # # # # # # # # # # # # # # VECTORS # # # # # # # # # # # # # # # # # # # # 
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

# create a scalar (Euler number) + pi
scalar <- pi - exp(1) 
scalar

# create an integer vector
int <- as.integer(1:10)
int
class(int)

# create an numeric vector
num <- scalar * int
num
class(num)

# see what is inside the third element in the vector num
num[3]
num[8:10]



# # # # start writing section # # # # 
# What is the difference between integer and numeric vectors?
# uno es una varaible continua, el otro discreto
# Can you see the elements from 5 to 9 in the vector num?
num[5:9]
# Can you sum the num and int vector?
num + int


# # # # finish writing section # # # # 



# vector multiplication
# Hadamard product OR element wise multiplication. The result is a vector.
num * int

# dot product OR inner product. The result is a scalar. 
sum(num * int)
num %*% int


# create a character vector
str <- as.character(c(10,2,5,2,0:5))
str
class(str)

# create a concatenated (sum) string vector by pasting 
strCon <- paste0(str,letters[1:10],LETTERS[10:1])
strCon

# create a factor vector (this is useful for regressions)
LetVec <- rep(LETTERS[1:4], 4)
LetVec
fac <- factor(LetVec, levels = c("B","A","C","D"))
fac
class(fac)
table(fac)



# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # ####
# # # # # # # # # # # # # # # # MATRICES# # # # # # # # # # # # # # # # # # # # 
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

# Paste vectors side to side to create a matrix. Columns bind. 
mat <- cbind(int,num)
mat
class(mat)

# create a matrix from scratch
mat2 <- matrix(rnorm(12),nrow=3,ncol=4)
mat2
class(mat2)
# NOTE: if rnorm() does not specified mean and sd then is a standard normal also known as z distribution

# do you want to constrain the randomness? add a seed
set.seed(1)

# create a more than 2 dimensional matrix (or array)
mat2 <- array(rnorm(27),dim = c(3,3,3))
mat2
class(mat2)

# to take the first column of a matrix
mat[,1]

# to take rows 2 and 7 from the matrix
mat[c(2,7),]



# # # # start writing section # # # # 
# Create an array of 4 x 3 x 2 dimensions filled with 1 values

# Create a second array where you add a standard normal random variable

# Can you sum two matrices?



# # # # finish writing section # # # # 






# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # ####
# # # # # # # # # # # # # # # # BOOLEAN LOGIC # # # # # # # # # # # # # # # # # 
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

# which of the numbers of the first column from mat is a 6?
mat[1,1] == 1
mat[,1] == 6

# which numbers are smaller than 7 and larger than 4
mat[,1] < 7 & mat[,1] > 4

# select rows with numbers smaller than 3 in the first column
mat[mat[,1] < 3,]



# # # # start writing section # # # # 
# what is the proportion of numbers larger than 1 in the mat2 matrix?

# Can you multiply two matrices?



# # # # finish writing section # # # # 



# useful way to install packages
if (!require(mvtnorm)) {install.packages("mvtnorm")}; library (mvtnorm)



# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # ####
# # # # # # # # # # # # # # # # CODING STATEMENTS # # # # # # # # # # # # # # # 
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

# a for loop
exponential <- as.vector(NA)
for (i in 1:10) {
  print(i)
  exponential[i] <- exp(i) 
}
plot(exponential)

#OR with no for loop
plot(exp(1:10))



# an if statement
rand <- rnorm(1)
if (rand < 0) {
  message("random variable is lower than 0")
} else if (rand >= 0 & rand < 1) {
  message("rand is between 0 and 1")
} else {
  message("rand is larger than 1")
}



# # # # start writing section # # # # 
# Create a for loop to count how many even numbers are between 0 and 100?

# Create a loop to ploy a logarithmic function where x = 1:10

# create a function that tells me whether the numbers within a numeric vector 
# are larger or smaller than a number xi 
posOrNeg <- function (x, xi) {
  x <- ifelse(x > xi, "larger", "smaller")
  return(list(x,table(x)))
}
# random variable
x <- rnorm(100)
# call the function
posOrNeg(x, 0)



# # # # finish writing section # # # # 



# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # ####
# # # # # # # # # # # # # # # # LISTS # # # # # # # # # # # # # # # # # # # # # 
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

# example
a <- hist(bvn5[,1], breaks = 20, xlim = axis_lim)
class(a)
a

# how to access the elements within the list?
a$counts
# OR
a[[2]]


# create hour list
myList <- list(list(int,num,exponential),mat,mat2)

# access to the exponential vector
myList[[1]]
myList[[1]][[3]]

# access to the 2d matrix
myList[[2]]


# you can name the list spaces 
myList <- list(mat1D = list(int=int,num=num,exp=exponential),mat2D = mat, mat3D = mat2)
myList$mat1D$exp
myList$mat2D






# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # ####
# # # # # # # # # # # # # # # # PROBABILITY # # # # # # # # # # # # # # # # # # 
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

# # # # # Bernoulli Distribution # # # # #

# how many events?
n <- 10000

# mean and/or sufficient statistic
p <- .5

# simulation
X <- rbinom(n, 1, p)

# call package for visualization
library(ggplot2)
X <- data.frame(x = as.character(c(rep(1,n), rep(0,n))),
                f_x = c(X, 1-X))
ggplot(X,aes(x=x,y=f_x)) + 
  stat_summary(geom="bar") +
  ylim(c(0,1))



# # # # # Binomial Distribution # # # # #

# probability of obtaining 80% correct in the ENARM given that you respond at chance?

# how many random samples?
N <- 1000

# how many questions? (size)
n <- 100

# parameter at chance?
p <- 1/4

# simulation distribution of a die
X <- rbinom(n = n, size = n, prob = p)

# simple visualization
plot(table(X)/N)

# theoretical mean: E[X]=k*p
n*p
# theoretical variance: var[X]=k*p*(1-p)
n*p*(1-p)

# expected value experimental mean
mean(X)
# experimental variance
var(X)


# call package for visualization
library(ggplot2)
X <- data.frame(X=X)
ggplot(X, aes(x=X)) + 
  geom_histogram(binwidth=1, color="black", fill="white") +
  geom_vline(xintercept = 80, color="blue", linetype="dashed", size=1)






# # # # # Normal Distribution # # # # #

# Number of random samples
N <- 1000 

# simulate a distribution of IQ (mean 100 and sd 15)
iq_dist <- rnorm(N, mean = 100, sd = 15)

# see the histogram
hist(iq_dist)
# more resolution ?
hist(iq_dist, breaks = 50)

# other distributions
# uniform
uniform <- runif(N,min = 0, max = 1)
hist(uniform,20)

# beta
beta <- rbeta(N,0.5,0.5)
hist(beta,20)

beta <- rbeta(N,1,1)
hist(beta,10)



# multivariate normal distribution (useful to cognitive modeling and reinforcement learning)

# Parameters for bivariate normal distribution
# two means
mu <- c(2,0)
# sigma matrix (variance-covariance matrix)
sigma <- matrix(c(  1, -1,
                    -1,   2), nrow = 2, ncol = 2)
# simulate N data points
bvn5 <- mvtnorm::rmvnorm(N,mu,sigma)


# create a vector for the axis limits
axis_lim <- c(-5,6)

# visualize the joint distribution
plot(bvn5[,1],bvn5[,2], xlim = axis_lim, ylim = axis_lim)

# visualize the marginal for the first dimension
hist(bvn5[,1], breaks = 20, xlim = axis_lim)

# visualize the marginal for the second dimension
hist(bvn5[,2], breaks = 20, xlim = axis_lim)

