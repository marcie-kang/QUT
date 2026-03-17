# ---------------------------------------------------------------------------- #
# ------------------------------- Week 3 R Code ------------------------------ #
# ---------------------------------------------------------------------------- #





# ------------------------------ Building Plots ------------------------------ #
#install.packages("tidyverse")
# Start by loading the ggplot2 package, which contains the ggplot() function.
library(tidyverse)
library(ggplot2)  # included in tidyverse, but fine if you keep it explicit
# NOTE: If you receive an error (no package called 'ggplot2'), you will need to
#       install it. To do this, use the install.packages() function.

# To make a plot, we need data.
xvar <- 1:10 # Create a series/vector of integers from 1 to 10 and assign it to the variable xvar.
yvar <- 1:10
df <- data.frame(xvar, yvar) # Create a data frame called 'df' using the vectors 'xvar' and 'yvar' as columns.
View(df)

# A ggplot() call starts with the data.
ggplot(data = df) # gray background; Initialize a ggplot object using the data frame 'df'

# A data set can contain many variables, so it's a good idea to tell R which
# variables ggplot should use.
ggplot(data = df,
       aes(x = xvar,
           y = yvar)) 
# The 'aes()' function defines aesthetic mappings, which tell ggplot how to map


# You can now see the graph axes are populated. Next, we add a geometry feature
# to the plot. This tells R what we want to show with our data. The shape of data.
# Let's start with a scatter plot.
ggplot(data = df,
       aes(x = xvar,
           y = yvar)) + 
  geom_point()
# The 'geom_point()' function tells ggplot to display each observation as a point.
# More options available

ggplot(data = df, aes(x = xvar, y = yvar)) + geom_point() #space doesn't matter




# ------------------------- Example using real data -------------------------- #
# For an example using real data, let's load bone.csv using the base R function,
# read.csv(). This data set contains bone mineral density measurements for 261
# North American adolescents. 
# The variable "spnbmd" represents the change in
# bone mineral density divided by time between two successive visits.

# read_csv("bone.csv") from the tidyverse package
#bone <- read.csv("data/bone.csv") #a function from base 
bone <- read.csv("bone.csv") #a function from base 
#getwd()

head(bone)
#first column of 1 2 3 4 5 6 ... are from R; X: from the csv file
#idnum: the participation number; repeated measurement every year;


ggplot(data = bone,
       aes(x = age,
           y = spnbmd)) +
  geom_point()

# Re-writing axis labels is also handled in code.
ggplot(data = bone,
       aes(x = age,
           y = spnbmd)) +
  geom_point() +
  labs(x = "Age (years)",
       y = expression(Rel.~BMD~(g~cm^-3~yr^{-1}))) 
# expression() function is used to create mathematical annotations in plots.
# Space represented by "~". Next to the exclamation mark.
# NOTE: Please explore different ways to achieve the same result. Some of these
#       include xlab() and ylab(), or even read_csv() from the "readr" library.

ggplot(data = bone, aes(x = age, y = spnbmd)) +
  geom_point() +
  xlab("Age (years)") +
  ylab(expression(Rel.~BMD~(g~cm^{-3}~yr^{-1}))) #curly brackets {-3}


# Themes can be used to change a range of aesthetic properties such as plot
# borders, plot backgrounds, and even axis line types, colours, and frequency.
# The most frequently used theme is "theme_bw()". 
# You can try a range of themes
# quite easily by storing your ggplot in the global environment. For example:
plot1 <- ggplot(data = df,
             aes(x = xvar,
                 y = yvar)) +
  geom_point()

plot1
plot1 + theme_bw()
plot1 + theme_dark()
# Try a range of different themes with the bone data plot above to find your
# favourite. Some theme examples include bw, linedraw, light, dark, minimal,
# classic, and void.
#plot1 + theme_linedraw()

plot1+ theme_light()


# -------------------------------- Histogram --------------------------------- #
# A histogram is a type of "univariate" plot. I.e., a plot showing information
# for a single variable.
# Looking at the frequency of different values of a variable

#A histogram is a type of bar chart that represents the distribution of numerical data. 
#It consists of bars where each bar represents the frequency (or count) of 
#data points within a specific range (or bin). 
#The height of each bar indicates how many data points fall within that range.


#Let's use new data
calf = 1:10 # makes a series of numbers 1 to 10
# c() function in R stands for "combine" or "concatenate." 
# It is used to create vectors by joining together individual elements.
breed = c("AN","CH","HE","AN","CH","HE","CH","AN",
          "HE","CH") # character strings
Sex = c("M","M","M","M","F","F","F","F","F","M")
BWT = c(55,68,60,52,65,64,70,61,63,75) #Birth Weight
df.wt <- data.frame(Calf = calf, 
                      Breed = breed, 
                      Sex = Sex,
                      BWT = BWT)

# Create a 2D plot of df.wt:
p2 <- ggplot(data=df.wt,
       aes(x=BWT)) + #y is always the frequency
  geom_point(y=0) + #It sets the y-value for every point to 0; 
                    #It ignores any y mapping from the main aes() and forces all points to be plotted along y=0.
  ylim(c(-1, 1)) +
  theme_bw() +
  xlim(c(50, 75)) +
  xlab("Calf birth weight (lbs)")

p2


# We could use ggplot.
ggplot(data=df.wt, aes(x=BWT)) + 
  # Add a histogram layer:
  # - 'binwidth = 5' sets the width of each bin to 5 units.
  # - 'center = 52.5' aligns the bins so that they are centered at 52.5 (and then every 5 units).
  geom_histogram(binwidth=5,
                 center=52.5,
                 color="black", fill="lightskyblue", alpha=0.5) +
  theme_bw() +
  labs(x="Calf birth weight (lbs)")


# This histogram might not be necessary because the data is small, but they can
# be very useful when summarising lots of data!
granite <- read.csv("granite.csv") #geology

ggplot(data = granite,
       aes(x=AreaMicron2)) +
  geom_histogram() +
  scale_x_log10() +  # Note the log scale - very easy to plot!
  labs(x=expression(Granite~grain~area~(mu*m^{2}))) +
  theme_bw()
# NOTE: Without scale_x_log10(), this is not a very effective visualisation!
# scale_x_log10() to transform the x-axis to logarithmic base 10. 
# This makes the histogram much more informative, 
# as it allows us to see the data in a more balanced way rather than having one bin dominate the view.

#1e+02: 1*10^2; scientific notation 

ggplot(data = granite,
       aes(x=AreaMicron2)) +
  geom_histogram() +
  #scale_x_log10() +  # Note the log scale - very easy to plot!
  labs(x=expression(Granite~grain~area~(mu*m^{2}))) +
  theme_bw()



# --------------------------------- Boxplot ---------------------------------- #
# A boxplot is a graphical representation of a "five number summary", which
# includes:
# * Minimum (0th percentile)
# * 1st quartile (25th percentile); 25% values are lower than the 1st quartile
# * Median (50th percentile)
# * 3rd quartile (75th percentile)
# * Maximum (100th percentile)

# A boxplot is useful for visualising the "spread" of data.

# We can derive the function of a boxplot for our calf weight data using the
# quantile() function.
df.q <- data.frame(quantile(df.wt$BWT))
names(df.q) <- c("x")

p2 +
  geom_vline(data=df.q,
             aes(xintercept = x),
             lty=2)
# Add vertical lines to the existing plot 'p2'
# Here, the data frame 'df.q' provides the x-intercept values via the column 'x'.
# The 'aes(xintercept = x)' maps the x-intercept for the vertical lines.
# The parameter 'lty=2' sets the line type to dashed.

#lty = "solid"    # Equivalent to 1
#lty = "dashed"   # Equivalent to 2
#lty = "dotted"   # Equivalent to 3
#lty = "dotdash"  # Equivalent to 4
#lty = "longdash" # Equivalent to 5
#lty = "twodash"  # Equivalent to 6



# Or... We could use ggplot.
ggplot(data=df.wt, aes(x=BWT)) + #We begin with our data frame, df.wt, and map the variable BWT to the x-axis. 
  geom_boxplot() + #we generate a boxplot that shows the median, quartiles, and potential outliers for calf birth weight.
  theme_bw() +
  labs(x="Calf birth weight (lbs)") +
  xlim(c(50, 75))

# Boxplots can also be useful when exploring variables across some grouping
# structure. We have a great example of this in our granite data set, where
# the variable "AreaMicron2" might change depending on the "Phase" categorical
# variable.
df.g2 <- group_by(granite, Phase)
# Use the group_by() function from the dplyr package to group the 'granite' data frame by the 'Phase' variable.
# This groups the data into subsets based on the unique values of 'Phase', 
# which is useful for performing operations
# (such as summarizing or calculating statistics) on each group individually.
summarise(df.g2,
          AM.min = min(AreaMicron2, na.rm=T),
          AM.median = median(AreaMicron2, na.rm=T),
          AM.max = max(AreaMicron2, na.rm=T))

# ggplot makes this easy!
ggplot(data=granite, 
       aes(x=Phase, y=AreaMicron2)) +
  geom_boxplot() +
  scale_y_log10() +
  theme_bw() +
  labs(y=expression(Granite~grain~area~(mu*m^{2})))
# NOTE: You will also see some dots, which are added functionality of
#       geom_boxplot(). These dots represent outliers (values that are far away
#       from the centre, based on the spread in our sample).

#The lines (or “whiskers”) extending from the box indicate the spread of the data outside the IQR. 
#They typically extend to the smallest and largest values that are not considered 
#outliers (often defined as within 1.5 times the IQR from the quartiles).

#e+02 is scientific notation.
#It means “multiply by 10 to the power of 2.


ggplot(data=granite, 
       aes(x=Phase, y=AreaMicron2)) +
  geom_boxplot() +
  scale_y_continuous(trans = "log") + #uses the natural log, meaning base e.
  theme_bw() +
  labs(y=expression(Granite~grain~area~(mu*m^{2})))



# ------------------------------ Scatter Plot -------------------------------- #
# Showed this earlier in the lecture.

# For each observation in the data, a scatter plot represents each pair of
# values (x, y), as a point in the graph.

# Can show more structure in the data by setting aesthetics of the geometry
# mapping variables to graphical elements). E.g., showing difference between
# male and female relative bone density values with different colours.
ggplot(data = bone,
       aes(x = age, y = spnbmd)) +
  geom_point(aes(color = gender)) + 
  labs(x = "Age (years)",
       y = expression(Rel.~BMD~(g~ cm^{-3}~yr^{-1}))) +
  theme_bw() +
  theme(legend.position="bottom")

#geom_point(aes(color = gender)): This layer creates a scatter plot where each point's color 
#is determined by the 'gender' variable, allowing us to easily distinguish between groups.

# ggplot(data = bone,
#        aes(x = age, y = spnbmd)) +
#   geom_point() +
#   labs(x = "Age (years)",
#        y = expression(Rel.~BMD~(g~ cm^{-3}~yr^{-1}))) +
#   theme_bw() +
#   theme(legend.position="bottom")

# shortcut to comment or uncomment selected lines: Windows / Linux: Ctrl + Shift + C; Mac: Cmd + Shift + C



# -------------------------------- Line Plot --------------------------------- #
# Similar to a scatter plot, but joins pairs of values. Useful to show changes
# happening over time. For this reason, line plots are often referred to as
# time series plots.
# NOTE: Use only when (x,y) are ordered pairs of numeric values, e.g., x is
#       time or date.

# For example, we can use the "airquality" data set from Week 1 to show changes
# in daily mean ozone over time.
aq.df <-
  mutate(airquality,
         Date = as.Date(paste("1973", Month, Day, sep="-")))
# Use the mutate() function from dplyr to add a new column to the airquality data frame.
# The new column 'Date' is created by combining the year 1973 with the 'Month' and 'Day' columns.
# The paste() function constructs a character string in the format "1973-Month-Day".
# as.Date() converts this character string into a Date object.
# paste("1973", Month, Day, sep="-"): This concatenates the strings "1973", 
# the month, and the day with hyphens, forming a date string like "1973-5-1".

ggplot(data=aq.df, aes(x=Date, y=Ozone)) + geom_line() + theme_bw() +
  labs(y="Concentration (ppb)", 
       title = "Daily mean Ozone in NYC (1973)")
# Don't draw between lines with NA
# NOTE: geom_line() stops plotting when it hits an NA value. If we have
#       individual measurements in a group of NA values, it won't plot that
#       value. However, we can use multiple geometries in ggplot, so we can
#       resolve this issue using geom_point().
ggplot(data = aq.df, aes(x = Date, y = Ozone)) +
  geom_line() +
  geom_point() +
  theme_bw() +
  labs(y = "Concentration (ppb)",
       title = "Daily mean Ozone in NYC (1973)")

#geom_point(): This function plots each observation as a point, 
#ensuring that we capture any isolated measurements that might be skipped by the line.


# ---------------------------------------------------------------------------- #
# ------------------------------ EXTRA OPTIONS ------------------------------- #
# ---------------------------------------------------------------------------- #





# ------------------------------- Smooth plots ------------------------------- #
# Sometimes, it can be difficult to see a pattern when there are too many data
# points. If we want to show the reader the trend in the data, we can use
# geom_smooth() to generate a scatter plot smoother that shows the overall
# relationship between x and y.
ggplot(data = aq.df, aes(x = Temp, y = Ozone)) +
  geom_point() +
  geom_smooth() +
  theme_bw() +
  ylab("Ozone (ppb)") +
  xlab(expression(Temperature ~ (degree * F)))

#geom_smooth() adds a smooth trend line to help us visualize the overall relationship, 
#including a confidence interval (estimation of uncertainty).



# ----------------------------- Small Multiples------------------------------- #
# Small multiples, or faceting, can be used to group a data set by some
# categorical variable, repeating a basic graph for each group in the data set.

# Using small multiples is a good alternative to creating 3D plots, since
# it doesn't distort comparisons visually and can include more than 3
# dimensions.

# For example, consider the histogram created earlier to visualise a part of
# the "granite" data set.
ggplot(data = granite,
       aes(x=AreaMicron2)) +
  geom_histogram() +
  scale_x_log10() +
  labs(x=expression(Granite~grain~area~(mu*m^{2}))) +
  theme_bw()

# We can tell R to repeat the histogram geometry for each level of the "Phase"
# variable using the facet_wrap() function.

ggplot(data = granite,
       aes(x=AreaMicron2)) +
  geom_histogram() +
  scale_x_log10() +
  labs(x=expression(Granite~grain~area~(mu*m^{2}))) +
  theme_bw() +
  facet_wrap(~Phase)
#we use facet_wrap(~Phase) to split the plot into separate panels based on the 'Phase' variable, 
#allowing us to compare the distributions across different phases.

# If we have two (or more) grouping variables, we can use facet_grid(V1 ~ V2)
# to tell R to repeat the plotting geometries for each value of V1 and V2 as
# rows and columns of a grid.

# First, we need to make a data set with two categorical variables. Remember
# the "ldeaths" data set? Well, it is comprised of "mdeaths" and "fdeaths".
mdeaths #male
md.df <- as.data.frame(matrix(mdeaths, ncol=12, byrow=T))
# with byrow = TRUE (or T), it fills across the first row, then the second row, and so on
names(md.df) <- month.abb
md.df <- mutate(md.df, Year = 1974:1979)
md.long <- pivot_longer(md.df,
                        cols = month.abb,
                        names_to = "Month",
                        values_to = "Deaths")

fdpivot_longerfdeaths #female
fd.df <- as.data.frame(matrix(fdeaths, ncol=12, byrow=T))
names(fd.df) <- month.abb
fd.df <- mutate(fd.df, Year = 1974:1979)
fd.long <- pivot_longer(fd.df,
                        cols = month.abb,
                        names_to = "Month",
                        values_to = "Deaths")

# Combine the two data frames md.long and fd.long into one.
# First, we add a new column 'Sex' to each data frame:
# - For md.long, we add Sex = "Male"
# - For fd.long, we add Sex = "Female"
# Then, we row-bind them together using rbind() to create one combined data frame ld.df.
ld.df <- rbind(cbind(md.long, Sex = "Male"),
               cbind(fd.long, Sex = "Female"))
# cbind(md.long, Sex = "Male")
# adds a new column called Sex to md.long, with every row set to "Male".
# 
# cbind(fd.long, Sex = "Female")
# adds a new column called Sex to fd.long, with every row set to "Female".
# 
# rbind(...)
# then stacks those two datasets on top of each other into one larger data frame.

# Use mutate() from the dplyr package to add a new column 'Month.n' to ld.df.
# The new column converts the 'Month' variable into a factor in the order it appears (using fct_inorder()),
# and then converts that factor into numeric. 
# This creates a numeric representation of the month order.
final_v2_really <- mutate(ld.df, Month.n = as.numeric(fct_inorder(Month)))

# Now we can exercise our face_grid:
ggplot(data = final_v2_really,
       aes(x=Month.n, y=Deaths)) +
  geom_line() +
  facet_grid(Sex ~ Year) +
  theme_bw() +
  scale_x_continuous(breaks = c(1,7),
    labels = c("Jan", "Jul"),
                     minor_breaks = seq(1,12),
                     name="Month of the year")

#The plot is divided into panels using facet_grid(Sex ~ Year), 
#so that each row represents a different sex and each column a different year. 
#This makes it easier to compare patterns across these groups.

#scale_x_continuous(): We set the major breaks at 1 and 7, which we label as "Jan" and "Jul" respectively, 
#while minor breaks are added for every month (from 1 to 12). 
#The breaks argument in scale_x_continuous() specifies the positions along the 
#x-axis where major tick marks (and their labels) are placed. 

# ggplot(data = final_v2_really,
#         aes(x=Year, y=Deaths)) +
#    geom_line() +
#    facet_grid(Sex ~ Month) +
#    theme_bw() 



# -------------------------------- Aesthetics -------------------------------- #
# ggplot2 allows you to customise your geomtry arguments, allowing a user to
# consider aspects other than x and y coordinates. This list includes:
# * Group (repeat geometry for a grouping variable in the same axis)
# * Size
# * Shape
# * Colour
# * Alpha (transparency)
# * Fill colour

# GROUP
# Instead of splitting up all data using small multiples, we can instead use
# grouping to show each group on a common set of axes.

# For example, how can we assess changes in relative bone density in our bone
# data set?
bone2 <- bone[bone$idnum<=5,]

# It can be very silly to use facet_wrap when there are many levels.
ggplot(data = bone2, aes(x = age, y = spnbmd)) +
  geom_point(alpha=0.1) + facet_grid(idnum ~ gender) +
  geom_line() +  theme_bw() +
  labs(x = "Age (years)", y = expression(Rel.~BMD~(g~cm^{-3}~yr^{-1})),
       title = "Relative spinal bone mineral density")

# However, just joining them all together doesn't let us assess any trends.
ggplot(data = bone2, aes(x = age, y = spnbmd)) +
  geom_point(alpha=0.1) + facet_wrap(~gender) +
  geom_line() +  theme_bw() +
  labs(x = "Age (years)", y = expression(Rel.~BMD~(g~cm^{-3}~yr^{-1})),
       title = "Relative spinal bone mineral density")

# Solution: Use the group aesthetic!
ggplot(data = bone2, aes(x = age, y = spnbmd)) +
  geom_point(alpha=0.1) + facet_wrap(~gender) +
  geom_line(aes(group=idnum)) +  theme_bw() +
  labs(x = "Age (years)", y = expression(Rel.~BMD~(g~cm^{-3}~yr^{-1})),
       title = "Relative spinal bone mineral density")
#By specifying group = idnum inside the aesthetic mapping, 
#we ensure that points belonging to the same individual (identified by 'idnum') are connected by lines.

ggplot(data = bone2, aes(x = age, y = spnbmd)) +
  geom_point(alpha=0.1) + facet_wrap(~gender) +
  geom_line(aes(group=idnum, color = factor(idnum))) +  theme_bw() +
  labs(x = "Age (years)", y = expression(Rel.~BMD~(g~cm^{-3}~yr^{-1})),
       title = "Relative spinal bone mineral density")


# For full data set:
ggplot(data = bone, aes(x = age, y = spnbmd)) +
  geom_point(alpha=0.1) + facet_wrap(~gender) +
  geom_line(aes(group=idnum)) +  theme_bw() +
  labs(x = "Age (years)", y = expression(Rel.~BMD~(g~cm^{-3}~yr^{-1})),
       title = "Relative spinal bone mineral density")

# COLOUR, FILL, ALPHA, AND SHAPE
# * The colour aesthetic refers to the external part of the plotting geometry.
# * The fill aesthetic refers to the internal part.
# * Size refers to the elements of the plotting geometry (radius of points
#   thickness of lines, etc.).
# * Alpha refers to the transparency (1 = solid, 0 = fully transparent). This is
#   useful when you have a lot of data on top of each other in a plot.
ggplot(data=airquality, aes(x=Temp, y=Ozone)) +
  geom_point(alpha=0.25, size = 5, shape = 22, color = "black", fill = "red") + theme_bw() +
  labs(x=expression(Temperature~(degree*C)), y="Ozone concentration (ppb)")




# ------------------------------ Scale Options ------------------------------- #
# Many scale functions allow us to set options for the relevant aesthetic and
# corresponding legend name, e.g.,
# * scale_colour_gradient(low="red", high="blue")
#   Makes a blue to red gradient for when we use aes(color=...)
# * scale_fill_brewer(palette="Pastel12")
#   Sets a colour palette for aes(fill=...)
# * scale_shape(name="Transmission", ...)
# * And others, such as scale_shape(), scale_x_log10().

# Find more by looking through the ggplot2 library documentation.

# Final example using the "mtcars" data set.
head(mtcars)

#wt	Weight (1000 lbs)
#mpg	Miles/(US) gallon
#am	Transmission (0 = automatic, 1 = manual)
#cyl	Number of cylinders

ggplot(data = mtcars, aes(x = wt, y = mpg)) +
  geom_point(alpha = 0.9,                    # Add points to the plot with slight transparency (alpha = 0.9)
             aes(shape = factor(am),         # Map point shape to the transmission type (am), converting it to a factor; treating it as a categorical variable rather than a continuous numeric variable.
                 color = factor(cyl),         # Map point color to the number of cylinders (cyl), converting it to a factor
                 size = factor(gear))) +      # Map point size to the number of gears (gear), converting it to a factor
  theme_bw() +                               
  scale_shape(name = "Transmission",         # Customize the shape legend title
              breaks = c("0", "1"),          # Specify the factor levels for transmission
              labels = c("Auto", "Manual")) + # Label the levels: 0 as "Auto" and 1 as "Manual"
  scale_size_discrete(name = "Gears") +        # Customize the size legend title for the gears
  scale_color_brewer(name = "Cylinders",       # Customize the color legend title for cylinders
                     palette = "Pastel2") +   # Use the "Pastel2" palette from ColorBrewer for the colors
  xlab("Weight (1000lbs)") +                   
  ylab("Fuel efficiency (mpg)")               
  
#breaks = c("0", "1"):
#This specifies which values (levels) of the am variable (after it’s converted to a factor) should appear in the legend. 

#labels = c("Auto", "Manual"):
#This provides more descriptive names for the levels listed in the breaks. Instead of showing "0" and "1" in the legend, the plot will display "Auto" for "0" and "Manual" for "1".





# ---------------------------------------------------------------------------- #