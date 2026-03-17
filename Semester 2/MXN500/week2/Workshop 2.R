#Workshop 2 

#  IS USED TO ADD NOTES TO YOUR CODE

#Read file
library(tidyverse)
Ecology <- read.csv("Ecologyv2.csv")

#Identify variables and units (Atyidae and dissolved oxygen)

#Plot a histogram to show the distribution (count) of a continuous variable 

#install.packages("ggplot2")
library(ggplot2)

# aesthetic(x axis = name of the variable to plot ) + graph() 
ggplot(data=Ecology, aes(x=DO)) + geom_histogram()

#Modify spaced ranges
ggplot(data=Ecology, aes(x=DO)) + geom_histogram(binwidth = 1)

#Label x and y axis
ggplot(data=Ecology, aes(x=DO)) + geom_histogram(binwidth = 1) + xlab("Disolved oxygen (mg/L)") + ylab("Number of observations")

#Add ranges 
ggplot(data=Ecology, aes(x=DO)) + geom_histogram(binwidth = 1) + xlab("Disolved oxygen (mg/L)") + ylab("Number of observations")+  scale_x_continuous(breaks = seq(min(Ecology$DO), max(Ecology$DO), by = 1))

# Graph bar for discrete variables 
#Example 1
ggplot(data = Ecology, aes(x= Substrate  ))+ geom_bar() + xlab("Substrate")

#Example 2 
ggplot(data = Ecology, aes(x= Atyidae  ))+ geom_bar() + xlab("Atyidae")

#Histogram of a discrete variable
ggplot(data=Ecology, aes(x=Atyidae)) + geom_histogram(binwidth = 1) 

#Modify graph plus adding colours
p <- ggplot(data=Ecology, aes(x=Atyidae)) + geom_histogram(binwidth = 20,  color= "purple", fill = "lightskyblue") + scale_x_continuous(breaks = seq(0,160,20)) + theme_bw()
print(p)

q <- ggplot(data=Ecology, aes(x=Atyidae)) + geom_histogram(aes(fill=..count..))
q
#Get info to inspect binning information
plot_info <- ggplot_build(p)
bin_info <- plot_info$data[[1]]  

#Modify starting bin point to correct R 
ggplot(data=Ecology, aes(x=Atyidae)) + geom_histogram(binwidth = 20, boundary=0,  color= "yellow", fill = "lightskyblue") + scale_x_continuous(breaks = seq(0,160,20)) + theme_bw()

#Map the colour of the instagram (DO NOT DO THIS!!!)
ggplot(data=Ecology, aes(x=Atyidae)) + geom_histogram(aes(fill=..count..))

#Scatter plot to show relationship between two continuous variables 
ggplot(data=Ecology, aes(x=Turbidity, y=DO))+ xlab("Turbidity, NTU")+ ylab("DO, mg/L")+ geom_point()

#Add line of best fit to help highlight relationship
ggplot(data=Ecology, aes(x=Turbidity, y=DO))+ xlab("Turbidity, NTU")+ ylab("DO, mg/L")+ geom_point() + geom_smooth()

#Identify the corresponding discrete variable for each point (Only use qualitative color schemes for this case)
ggplot(data=Ecology, aes(x=Turbidity, y=DO))+ xlab("Turbidity, NTU")+ ylab("DO, mg/L")+ geom_point(aes(color=Location)) + geom_smooth() + scale_color_brewer(palette = "Dark2") + theme_bw()

# install.packages("RColorBrewer") to choose a different pallet (do this later as it would ask you to restart R)
RColorBrewer::display.brewer.all()

png("RColorBrewer_palettes.png", width = 1200, height = 1000)

RColorBrewer::display.brewer.all()

dev.off()

#Vegan library <- install.packages("vegan")
#Separate specific variables for analysis
names(Ecology)
Ecology_species <- select(Ecology, Parastacidae:Plecoptera)

library(vegan)
#Create a new column of data using mutate and determine the total of different species per site
Ecology <- mutate(Ecology, TaxonRichness = specnumber(Ecology_species) )
select(Ecology, Site, TaxonRichness)

#Bar plot for subplots (individual sites)
ggplot(data = Ecology, aes(x= Site, y=TaxonRichness )) + geom_col(aes(fill = DO)) +  theme_bw() +  scale_fill_gradientn(colours = rainbow(7), name = "Dissolved Oxygen") + 
  facet_wrap(facets = ~ Location, nrow = 1, scales = "free_x") + ylab("Taxon Richness (Species)") +  ggtitle("Taxon Richness by Site and Location") +theme(plot.title = element_text(hjust = 0.5, size = 8, face = "bold"), strip.text = element_text(size = 7),axis.title.y = element_text(size = 8, face = "bold"), axis.text.x = element_text(size = 5, face = "bold") )

#Improved option to represent the previous graph
ggplot(data = Ecology, aes(x = DO, y = TaxonRichness))+theme_bw()+ geom_point(aes(colour = Location), size = 3) + xlab("Dissolved Oxygen (mg/L)") + ylab("Taxon Richness (Species)") +  ggtitle("Taxon Richness by Site and Location") + scale_color_brewer(palette = "Dark2") + theme(plot.title = element_text(hjust = 0.5, size = 16, face = "bold"))+labs(caption = "Figure 1: Taxon richness varies by site and location, based on dissolved oxygen levels.")

# The worst option
library(ggplot2)

ggplot(data = Ecology) + facet_wrap(~ Location) + geom_violin(aes(x = DO, y = Richness), colour = "limegreen", fill = "orange", size = 2) + 
  geom_point(aes(x = DO, y = Richness, colour = DO, fill = Richness), pch = 2, size = 2, stroke = 4)  + geom_text(aes(x = DO, y = Richness, label = Site)) + 
  scale_color_gradient(low = "blue", high = "red") + theme_linedraw() + coord_polar()

