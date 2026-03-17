#Workshop 3

#Rounding and significant figures 
number <- 3.141617
number <- round(number, 3)
options (digits = 3)
number
signif(number, digits = 1)

#Load carData package -> install.packages("carData")
library(carData)
data("Burt")
head(Burt)


# What are research ethics? is it right that Burt's manufactured data? What should Burt have done? What ethics do you need to uphold throughout your careers?
#Create a data dictionary table 
ranges <- sapply(Burt, function(x) if(is.numeric(x)) range(x, na.rm = TRUE) else NA)
print(ranges)
Burt_Data_Dictionary <- data.frame(name = colnames(Burt),Description = c("IQ of the child raised by biological parents", 
"IQ of the child raised by the foster parents", "SOcio-economic class of the views"), type  = c("Interval", "Interval", "Ordinal"),
typical_range = c("63-132","68-131","low,medium,high") )

#Create a plot to show data
library(forcats)
library(ggplot2)
Burt$class <- as.factor(Burt$class)
Burt$class <- fct_relevel(Burt$class, "low", "medium","high")
ggplot(data = Burt, aes(x= IQbio, y= IQfoster))+ geom_point(aes(colour = class)) + theme_bw() + 
  xlab("IQ of Twin raised by Biological Parents") + ylab("IQ of twin raised by foster parents") + scale_colour_discrete(name = "Socio-economic class")

#Describe Burt's study 
# Explanatory - Independent variable / Outcome - Dependent variable 
# Design quality (# samples, performance, experiment design)
# Principles of experimental design (local control, randomise, repeat)
# Sample / Population
# Bias (Sampling, Procedure, Measurement, Data reporting)

#Activity 2

#Read file
library(tidyverse)
In_Porth <- read.csv("In Port.csv")
colnames(In_Porth)
#Variable type and class

#How many different ships are currently at Berth in Queensland ports?
library(dplyr)
n_distinct(In_Porth$Ship)
#How many distinct ships are currently at berth at each of the ports in Queensland?
group_by(In_Porth, Port) %>%
summarise(Count = n_distinct(Ship))

#Convert data frames to dates
class(In_Porth$Arr.Date)
str(In_Porth)

In_Porth$Arr.Date <- as.Date(In_Porth$Arr.Date, format = "%a %d %b %Y")
In_Porth$Dep.Date <- as.Date(In_Porth$Dep.Date, format = "%a %d %b %Y")
head(In_Porth)
# Check the structure of the whole data frame
str(In_Porth)
#Create a new column in the data frame that contains information on the amount of time each ship has been waiting so far
In_Porth <- mutate(In_Porth, Waiting = Sys.Date() - Arr.Date )


#Activity 3 
PortInfo <- read.csv("PortInfo.csv")
str(PortInfo)
#Clean data
PortInfo <- mutate(PortInfo,Port.Type = str_replace(Port.Type, "PortType.",""))
#Join data sets
AllPort <- left_join(In_Porth, PortInfo, by= c("Port"="Port.Name"))
head(AllPort)
str(AllPort)

#Maps install.packages("ggmap")
library(ggmap)
#Bounding box
bbox <- c(left= 137, bottom = -30, right = 155, top = -8)
#QLD map
#API key https://stadiamaps.com/ register to create an api key
register_stadiamaps(key = "8939818e-ac81-488c-8b1e-f8211b991108")
# stamer watercolor, terrain, background
qld_map <- get_stadiamap(bbox = bbox, zoom = 4, maptype = "stamen_terrain")
# INFO
?get_stadiamap
ggmap(qld_map)
#add port locations
ggmap(qld_map) + geom_point(data = PortInfo, aes(x= Longitude, y= Latitude))
#add Port names
ggmap(qld_map) + geom_point(data = PortInfo, aes(x= Longitude, y= Latitude)) + geom_text(data = PortInfo, aes(x= Longitude, y= Latitude, label = Port.Name), hjust= -0.1, size = 3)
#Ships at Port
ggmap(qld_map) + geom_point(data = PortInfo, aes(x= Longitude, y= Latitude)) + geom_jitter(data = PortInfo, aes(x= Longitude, y= Latitude) , width = 1, height = 1, colour = "pink", size= 2)

#Activity 4 data.gov.au
#Create a data dictionary
#Develop a scientif question
#Provide a table with summary statistics for 2 variables
#Create a plot
#Conclusions
