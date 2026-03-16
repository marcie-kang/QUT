# ---------------------------------------------------------------------------- #
# ------------------------------- Week 2 R Code ------------------------------ #
# ---------------------------------------------------------------------------- #





# ------------------------------ Data Types in R ----------------------------- #
# A "string" or character variable in R is anything entered in quotes.
character_string <- "This is a string" # A string is a sequence of characters.
single_character <- "a" # Even though it's a single character, it is still treated as a string.

# Create a character vector containing multiple elements.
character_vector <- c("a", "b", "b", "c", "a") # 'c()' is used to combine values into a vector.
str(character_vector[1])# Display the structure of the first element in 'character_vector'.
str(character_vector) #It reveals that 'character_vector' is a vector of characters with 5 elements.

# Selecting with vectors
sel_vec <- c(1,2,4)
character_vector[sel_vec]
character_vector[c(1,2,4)]

# Sorting with vectors
sort_vec <- c(4,1,2)
character_vector[sort_vec]

#Selection *and* sorting
sort2_vec <- c(3,1,2)
sel2_vec <- sel_vec[sort2_vec]
str(sel2_vec)
character_vector[sel2_vec]

# Composed select + sort
character_vector[sel_vec[sort2_vec]]



# Convert the character vector to a factor.
# A factor variable is how R treats categories of data.
factor_vector <- as.factor(character_vector)
str(factor_vector) # Display the structure of 'factor_vector'. 
# It shows that 'factor_vector' is a factor with a certain number of levels.

levels(factor_vector) # List the levels (unique categories) of the factor.


library(tidyverse)
# To create a data frame with categorical variables, use a vector of strings.
# This vector is treated as a factor by default, but this is only true for old R versions before 4.0.0
hml_df <- data.frame(category = c("High", "Medium", "Low"))
str(hml_df)
#In R < 4.0.0, data.frame() had stringsAsFactors = TRUE by default, 
#so a character vector like c("High","Medium","Low") would become a factor automatically.

# If you’re using R 4.0.0 or later. 
# the column "category" remains a character vector unless you instruct R to convert it.
hml_df <- data.frame(category = as.factor(c("High", "Medium", "Low")))
summary(hml_df) #count of each level
str(hml_df)
#3 rows and 1 column;
#R stores factors as integers that point to the levels list.
#str() is showing the levels order, not the row order.
#By default, when R converts characters to a factor, it creates levels in alphabetical order (unless we explicitly set them). 
#Alphabetically: High < Low < Medium.

# Factors default to an alphabetical order:
factor(hml_df$category) 
# In this case, the unique values ("High", "Medium", "Low") will be sorted as "High", "Low", "Medium". #values vs levels

# To change the order, we need to provide levels.
hml_df_ordered_factors <- hml_df
hml_df_ordered_factors$category <-
  factor(hml_df_ordered_factors$category,
         levels = c("Low", "Medium", "High")) # change the levels

# Compare the result:
factor(hml_df$category) # Order we don't want.
factor(hml_df_ordered_factors$category) # Order we want.

# You can convert string vector to a factor by:
hml_characters_df <- data.frame(category = c("High", "Medium", "Low"),
                                stringsAsFactors = TRUE)
str(hml_characters_df)
summary(hml_characters_df)

# Look what happens to these "numbers". Need to be careful to make sure your
# data is the correct type.
num_df <- data.frame(numbers = c("3.14", "-2", "15"))
str(num_df)
class(num_df$numbers)
mean(num_df$numbers)

# To make the data numeric need to change it's type
now_numbers <- as.numeric(num_df$numbers)
str(now_numbers)
mean(now_numbers)

# Be careful of these steps, can cause uncaught problems!
more_numbers <- c(2,6,"*8")
# Since one of the elements ("*8") is a non-numeric string, 
# R coerces the entire vector to character type.
mean(more_numbers)
# Because 'more_numbers' is a character vector (due to coercion), this operation will fail and produce NA with a warning.
str(more_numbers)

# fix this issue through 'coercion' i.e. 'as.numeric()'
# Fix the issue by coercing the character vector to numeric.
# The valid numeric strings will convert properly, but any non-numeric strings (like "*8") will become NA.
now_more_numbers <- as.numeric(more_numbers)
now_more_numbers
mean(now_more_numbers)
# Recalculate the mean while removing NA values by using the na.rm = TRUE argument.
mean(now_more_numbers, na.rm = T)
str(now_more_numbers)

# change in the data frame
num_df$numbers <- as.numeric(num_df$numbers)
str(num_df$numbers)
summary(num_df)
# or
library(dplyr) # in general, best to put library calls at the start of the file
num_df <- mutate(num_df,
                numbers = as.numeric(numbers)) #alter a column using mutate
str(num_df$numbers)
summary(num_df)

# of course you can also just provide the data in a
# numberic format - ie. no quotations
num_df <- data.frame(numbers = c(3.14, -2, 15))
str(num_df)
class(num_df$numbers)





# ------------------------------ Functions in R ------------------------------ #
# We can make our own functions
# Name the function (left hand side) and the inputs (right
# hand side, in brackets). Then, everything those inputs are used for are
# contained within "squiggly" brackets, {}. These are also called "braces".
# Some basic examples:
# The function takes one input parameter 'x'
add_one <- function(x) {
  x_new <- x + 1
  # Return the computed value stored in 'x_new' as the output of the function.
  return(x_new)
}


# In this case, a function called "add_one" is a function which takes some
# input, x, adds one to it, and returns the result.
# Test it out
add_one(5)
add_one(c(1,2,3,4))
x <- add_one(0)
x

#And break the function
add_one("a")
# The error message you receive may not be very descriptive.
# It simply indicates that the operation "x + 1" cannot be performed,
# and without looking at the function's definition, it may not be clear why.



# Here's another:
make_negative <- function(x) {
  x_new <- -x
  return(x_new)
}
make_negative(-6)
make_negative(1:10)



# Check how they work.
x <- 1
add_one(x)
make_negative(x)
# Note: The 'x' used in these function calls is the variable defined outside the functions.
# It is independent of any 'x' that might be used as a parameter inside the functions.
# It's a good practice to use meaningful and distinct variable names to avoid confusion.

# Interested in applying them one after each other? Composition of functions:
x_new <- make_negative(add_one(x))
x_new





# -------------------------------- Pipes in R -------------------------------- #
# The "pipe" operator, %>%, takes an object (an output, variable, or other R
# object) and sends it into the next function as the first argument of the
# function after the pipe.

# The pipe can be difficult to work with at first, but it can be useful for
# speeding up your R work once you get used to it.

# The pipe makes it easy to write clear, readable step-by-step code.
x_new <- x %>%
  add_one() %>%
  make_negative()
x_new
#Here’s what happens step-by-step:

#Start with the object x:
#  The value stored in x is our starting point.

#First pipe: x %>% add_one()
#The pipe operator takes x and passes it as the first argument to the function add_one().
#In other words, it’s equivalent to writing: add_one(x)

#Second pipe: %>% make_negative()
#Now the output from add_one(x) (which we expect to be a modified version of x) 
#is then passed as the first argument to make_negative().



# ---------------------------- Pipes in Practice ----------------------------- #
# Let's consider some real data and real use cases. We are going to use data
# from the Lahman package. This package is all about baseball.

install.packages("Lahman") # Install the package.
library(Lahman) # Load the package.
? Lahman # Read the help so you know what's in the package.

data(Batting) # Get the data out of this library.

dim(Batting) # Get a feel for the data (how big).
head(Batting) # What variables look like.
View(Batting)
? Batting # Column name definitions.

# For reshaping we need our favourite:
library(tidyverse)

# Let's look a one player, Manny Ramirez
manny <- filter(Batting, playerID == "ramirma02")

# Remember to use a logical operator to filter.
x = 1  # Single equals assigns in this case; an assignment
x == 1 # Double equals is asked 'are these two things equal'; a test
x == 2 #Boolean logical value

# What info do we have on Manny?
nrow(manny)
View(manny)

# Let's get some summary stats:
# unique values
# The function n_distinct() (from dplyr) counts how many distinct elements are in the vector.
# Here, the vector c("a", "a", "b") has two unique values: "a" and "b".
n_distinct(c("a", "a", "b")) 

# concatenate values/variables
# Concatenate the strings "a" and "b" using a custom separator "-".
# The paste() function combines strings, and here 'sep = "-"' 
# specifies that a hyphen is used to join them.
paste("a", "b", sep = "-") # 

# paste defaults to " " as the separator
# When no separator is specified, paste() defaults to using a space.
paste("a", "b","c")
# The output will join the strings with semicolons.
paste("a", "b","c", sep = ";")
# Here, an empty string is specified as the separator, so the strings are combined directly.
paste("a", "b","c", sep = "")

# works with other objects (variables, functions)
 a <- "hello"
 b <- "world"
 paste(a,b,42) # By default, paste() separates the values with a space. # This will output: "hello world 42"
 paste0(paste(a,b,42),"!")
 # Use paste0() to combine the result of paste(a, b, 42) with an exclamation mark "!".
 # paste(...) defaults to sep = " " (a space)
 # paste0(...) defaults to sep = "" (no separator)


# sums
sum(1:3)                   


# Use the summarise() function to calculate various statistics from the 'manny' dataset.
manny_stats <- summarise(manny,
                         span = paste(min(yearID), max(yearID), sep = "-"),
                         # Calculate the number of unique years the player appeared
                         numYears = n_distinct(yearID),
                         # Calculate the number of unique teams the player was part of
                         numTeams = n_distinct(teamID),
                         # Compute the batting average (BA) as the total number of hits (sum(H)) 
                         # divided by the total number of at bats (sum(AB)).
                         BA = sum(H)/ sum(AB),
                         # Calculate the total hits (tH) by summing the 'H' column.
                         tH = sum(H),
                         # Calculate the total home runs (tHR) by summing the 'HR' column.
                         tHR = sum(HR),
                         # Calculate the total runs batted in (tRBI) by summing the 'RBI' column.
                         tRBI = sum(RBI))
manny_stats
head(manny_stats)

#manny <- filter(Batting, playerID == "ramirma02")
# With the pipe, you could do this:
# Starting with the Batting data frame, we use the pipe operator (%>%) 
# to streamline our data manipulation steps.
# Each step passes its result as the first argument to the next function.
manny_being_manny <- Batting %>%
  filter(playerID == "ramirma02") %>%
  summarise(span = paste(min(yearID), max(yearID), sep = "-"), # Note also the paste() function here.
            numYears = n_distinct(yearID),
            numTeams = n_distinct(teamID),
            BA = sum(H) / sum(AB),
            tH = sum(H),
            tHR = sum(HR),
            tRBI = sum(RBI))
head(manny_being_manny)


# Might be interesting to break the stats down by team:
manny_team_stats <- Batting %>%
  filter(playerID == "ramirma02") %>%
  group_by(teamID) %>% # added in a group operator
  summarise(span = paste(min(yearID), max(yearID), sep = "-"),
            numYears = n_distinct(yearID),
            numTeams = n_distinct(teamID),
            BA = sum(H) / sum(AB),
            tH = sum(H),
            tHR = sum(HR),
            tRBI = sum(RBI))

head(manny_team_stats)

# To make the data more intuitive / readable.
# Might want to reorder by the years played for each team.
# Can use arrange for that.
example <- data.frame(number = c(2, 5, 1))
arrange(example, number)
# Use the arrange() function to sort the 'example' data frame by the 'number' column in ascending order.

manny_team_stats <- Batting %>%
  filter(playerID == "ramirma02") %>%
  group_by(teamID) %>%
  summarise(span = paste(min(yearID), max(yearID), sep = "-"),
            numYears = n_distinct(yearID),
            numTeams = n_distinct(teamID),
            BA = sum(H)/ sum(AB),
            tH = sum(H),
            tHR = sum(HR),
            tRBI = sum(RBI)) %>%
  arrange(span) # Now arrange by the span
#composing all steps by using pipe

head(manny_team_stats) 





# ---------------------------- Join Functions in R --------------------------- #
# Let's start with a toy example:
df1 <- data.frame(number = 1:3,
                 first_letters = c("a", "b", "c"))
df1

df2 <- data.frame(number = c(1:2, NA_real_, 4), 
                 last_letters = c("w", "x", "y", "z"))
df2


# Lot's of different ways to combine this data!

# Rows must exist in both data sets,
# Bi-directional:
inner_join(df1, df2)
# Perform an inner join on df1 and df2.
# This type of join only returns rows that have matching values in both data frames.
# The join is bi-directional: a row must exist in both df1 and df2 
# (based on the join keys) to be included in the output.

# Combine everything:
full_join(df1, df2)
# A full join returns all rows from both data frames.
# Rows with matching keys in both data frames are merged together.
# For rows that do not have a match in the other data frame, missing values are filled with NA.

# Rows must exist in the first data set.
# Directional joins - order matters:
left_join(df1, df2) # This adds columns from df2 to df1 for matching keys.
left_join(df2, df1) # This adds columns from df1 to df2 for matching keys.
# Use left_join() to combine two data frames, keeping all rows from the first (left) data frame.
# Any matching columns from the second data frame are added where available.
# If there is no match in the second data frame, the result will have NA for those columns.




# ----------------------------- Joins in Practice ---------------------------- #
# Now lets combine some real data sets
# Can use Master and batting data from Lahman package
data(Batting)
data(People)
#load a built-in example dataset named People into our workspace (from a package that contains it)

# first let's understand what we will join
# Manny - just get his data
manny_data <- Batting %>%
  filter(playerID == "ramirma02")
nrow(manny_data)
View(manny_data)

# combine using common entries in both
inner_join_batting_people <- manny_data %>%
  inner_join(People, by = "playerID")
# The inner_join() function combines two data frames by matching rows based on a common key.
# Here, we join 'manny_data' with 'People' on the column "playerID".
# This inner join returns only the rows where the "playerID" exists in both data frames.

# most of the time join functions are clever enough
# to know what to join by
inner_join_batting_people <- manny_data %>%
  inner_join(People)
# Using inner_join() without specifying the 'by' argument
# allows the function to automatically match columns with the same name in both data frames.
# In this case, if both 'manny_data' and 'People' have a column named "playerID",
# inner_join() will use that column as the key to join the data.

# playerID is the only common column in this example
names_batting <- names(Batting)
names_people <- names(People)
intersect(names_batting, names_people)
# Find the intersection of the two sets of column names.
# This returns a vector of names that are common to both 'Batting' and 'People'

# Let's look at what happened
View(inner_join_batting_people)
# basically, repeat the player details for each row of the players' batting
# stats.

# What if we used left_join instead
left_join_batting_people <- manny_data %>%
  left_join(People)
View(left_join_batting_people)
# same thing, because common rows in Manny player data were the constraint.
# left_join() keeps all rows from the left data frame ('manny_data') and adds matching information from 'People'.
# In this example, every row in 'manny_data' has a corresponding match in 'People',
# so the result is effectively the same as an inner join.

# What if we change the order?
left_join_people_batting <- People %>%
  left_join(manny_data)
View(left_join_people_batting)
# We don't just get the information about Manny.
# Can see we have no stats for the other players.
# Join order is important!
# Have to think about what you need before you join your data.










# ---------------------------------------------------------------------------- #
#
