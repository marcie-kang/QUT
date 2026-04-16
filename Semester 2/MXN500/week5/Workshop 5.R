#Workshop week 5

library(tidyverse)
library(ggplot2)
Height <- read.csv("HeightWeight.csv")
dim(Height)
str(Height)

#What is the objective of normal distribution model ?
#Parameters of normal distribution
#Values range 
#What is the range that would make sense for this problem?

# Parameters 
summarise(Height,"Mean"= mean(Height),"Standard Deviation"= sd(Height))

#Data distribution 
ggplot(data = Height, aes(x = Height)) + geom_histogram(aes(y= after_stat(density)), 
                                                        color= "black",fill= "orange",bins=15) +
  labs(x="Height(inches)", y= "Density")+ theme_bw()+ 
  stat_function(fun= dnorm, args = list(mean = mean(Height$Height), 
                                        sd = sd(Height$Height)), linewidth = 1)

# Is this model appropriate? bell curve ? symetric?

#Quantiles 
quantile(Height$Height, probs = 0.1)
quantile(Height$Height, probs = 0.9)

#Predictions 
#Calculate the height below which you expect to see 10% of future observations 
qnorm(p=0.1, mean= mean(Height$Height), sd=sd(Height$Height))

#Calculate the height above which you expect to see 10% of future observations 
qnorm(p=0.1, mean= mean(Height$Height), sd=sd(Height$Height), lower.tail = FALSE)
qnorm(p=0.9, mean= mean(Height$Height), sd=sd(Height$Height))

#Calculate the average height you would expect to see to the future observations 
qnorm(p=0.5, mean= mean(Height$Height), sd=sd(Height$Height))
mean(Height$Height)
median(Height$Height)

#Making predictions 
#Proportion of future people would we expect to see a height less than 63 inches?
pnorm(q=63, mean= mean(Height$Height),sd=sd(Height$Height))
#What is the probability that the next person has a height less than 64 inches?
pnorm(q=64, mean= mean(Height$Height),sd=sd(Height$Height))
#What is the probability that the next person has a height of greater 64 inches?
1-pnorm(q=64, mean= mean(Height$Height),sd=sd(Height$Height))
pnorm(q=64, mean= mean(Height$Height),sd=sd(Height$Height),lower.tail = F)
#Probability of the highest height in the data
max(Height$Height)
pnorm(q=max(Height$Height), mean= mean(Height$Height),sd=sd(Height$Height),lower.tail = F)
#Probability of a height of 0
pnorm(q=0, mean= mean(Height$Height),sd=sd(Height$Height))

#Quantile plots 

#Simulate 100 values from Z ~ N(0,1) 
sim <- data.frame(x= rnorm(n=10000))
mean(sim$x); sd(sim$x)
#Normal distribution plot
ggplot(data = sim, aes(x = x)) + geom_histogram(aes(y= after_stat(density)), 
                                                        color= "blue",fill= "red",bins=15) +
  labs(x="Random Observations", y= "Density")+ theme_bw()+ 
  stat_function(fun= dnorm, args = list(mean = 0, 
                                        sd = 1), linewidth = 1)

#Does the data look normally distributed?

#Compare simulated quantiles vs theorical quantiles
ggplot(data=sim, aes(sample=x))+ stat_qq()+ 
  geom_abline(intercept = 0, slope =1)+theme_bw()+coord_equal()

#Quantile plots Height problem
#Normalise the data to Z ~ (0,1)
standarise <- function(x){return((x-mean(x))/sd(x))}
library(dplyr)
Height <- mutate(Height, Height.std= standarise(Height))
sd(Height$Height.std)
mean(Height$Height.std)
#New histogram
ggplot(data = Height, aes(x = Height.std)) + 
  geom_histogram(aes(y= after_stat(density)), color= "gray",fill= "pink")+
  stat_function(fun= dnorm, linewidth = 1)
#Quantiles plot
ggplot(data=Height, aes(sample= Height.std))+ stat_qq()+ 
  geom_abline(intercept = 0, slope =1)+theme_bw()+coord_equal()
#Question 4
#ghh