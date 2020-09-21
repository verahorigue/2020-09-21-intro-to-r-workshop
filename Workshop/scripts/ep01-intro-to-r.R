#    ___       _               _          ____  
#   |_ _|_ __ | |_ _ __ ___   | |_ ___   |  _ \ 
#    | || '_ \| __| '__/ _ \  | __/ _ \  | |_) |
#    | || | | | |_| | | (_) | | || (_) | |  _ < 
#   |___|_| |_|\__|_|  \___/   \__\___/  |_| \_\
# 
# Derived from: https://datacarpentry.org/R-genomics/

#
# Topic: Basic Calculations and using Objects
# Presented by: Belinda Fabian

# R can do sums and divisions ...
3 + 5
12 / 7

# other operators -- subtraction, multiplication, and power of
#
# - * / ** ^ ( )

# 
# Excercises
#

# What does: 11 + 1 / 6  evaluate to ?

# Solution:
11+1/6

# Calculate 10 plus 2 all divided by 3 and then squared

# Solution:
((10+2)/3)^2



# Storing values
a <- 3              # assign the number 3 to OBJECT (variable) called "a"
b <- 5              # assign 5 to b

a                   # so what's the value of OBJECT "a"
b                   # ... and what's b

a + b               # we can add them together just like numbers

# --------
# Exercise
# --------
#
# What happens if we change a and then re-add a and b? [Hint: Try it now]

a = 2
a + b

# Does it work if you just change a in the script and then add a and b? [Hint: Try it]

a = 10
a + b

# Did you still get the same answer after you changed a? 
# If so, why do you think that might be?
# You need to store the variable in the script and run it

# We can also assign the result of a + b to a new variable, c. 
# How would you do this?


# Solution:
c = a + b 


# Logical operators
#
# == != < > >= <= !
# == means exactly equal to
# ! means not
# != means not equal to
# < means less than, > greater than; <= means less than or equal to, >= means greater than or equal to 
1 < 124

#
# Sensible object names are sensible ...
#
date_of_birth <- 7
z <- 19.5
THEMOL <- 42
camelCaseIsGenerallyNotRecommended <- "Unless you follow Google's Style guide" #this is a mixed capital and small caps
names_that_are_unreasonably_long_are_not_a_good_idea <- "correct"
nouns_are_good <- TRUE
TRUE <- 17
ekljre2jklwef023ijlefj93jkl23rj90f32k <- 1

# 
### Exercise
# 
#
# Assign the name of this workshop to a object with a good name.
#
# Solution: [Hint:       <- "Introduction to R"]

workshop_name = "Introduction to R"

# Assign the name of video conferencing tool we are using to an object
#
# Solution: [Hint:      <- "Zoom"]

conference_tool = "Zoom"


# Which of these are valid object names: [Hint: Try them out] -- VH: in Windows highlight the lines and press CTRL+shift+c
# VH: to check for the valid names, the ones that are invalid will be marked with an X

 min_height = 2
 max.height = 3
# _age #this is invalid because of the underscore is a special character
 _age = 9
 .mass = 10
 MaxLength = 8 #can have mix caps and small caps, but easy to forget them, so just stick to just one
 min-length = 11
 #2widths #because of the number
 2widths = 20
 celsius2kelvin = 2 #can mix numbers and letters, just don't start with a number

#
# Topic: Displaying results
#

weight_lb <- 55    # doesn't print anything
(weight_lb <- 55)  # but putting parenthesis () around and expression makes it display
weight_lb          # and so does typing the name of the object

# There are 2 and a bit pounds in a kilogram 
2.20462 * weight_lb

weight_lb <- 57.5
2.20462 * weight_lb

weight_kg <- 2.20462 * weight_lb
weight_kg

# 
# Exercise
# 
# 
# What are the values after each statement in the following?
 

mass <- 47.5            # mass is: 47.5
age  <- 122             # age is: 122
mass <- mass * 2.0      # mass is: 95
age  <- age - 20        # age is: 102
mass_index <- mass/age  # mass_index is: 0.93137525

# VH - we are overriding/ reassigning the values to the original variables -- mass and age
# How do we do we know if our answers are correct ? 
# [Hint: <highlight> [ALT][ENTER]

#
# Topic: Comments
#

# Comments (like this one) are usually helpful

     # they can also be indented

# They should be supportive (not redundant e.g. "this is a comment")

# 
# Exercise
# 
#
# Add explanatory comments to the following lines of code (VH: added comments below)
# VH: add comments to explain conversion

ft <- 3               #length in foot/ feet is 3
in <- ft * 12         #length in inches, convert from feet mutliply by 12
cms <- in * 2.54      #length in centimetres (cm), multiply inches by 2.54
m = cms / 100         #length in metres (m), multiply cm by 100

#
# Topic: Functions and Arguments

a = 16
sqrt(2)
sqrt(a)
abs(-23.3)
round(3.14159)
pi

# Getting help about particular functions 
?round
args(round)

round(3.14159, digits = 2)
round(digits = 2, x = 3.14159)

#
# Exercise
#
# what does the function called log10() do ?  Can you test it ?
#
# Answer:

log10("cat") #Error, because "cat" is not numerical
log10(10)
log10(100)
?log10



#
# Topic: Vectors and Data Types
# Presented by: Richard Miller

# Combine some values in a vector
glengths <- c(4.6, 3000, 50000)
glengths

species <- c("ecoli", "human", "corn")
species

length(glengths) #there are 3 data inputs
length(species)  #there are 3 species

5 * glengths     #multiply all the data inputs in your object by 5

double_lengths <- glengths + glengths
double_lengths

class(glengths) #will describe things as numeric
class(species)  #will describe things as characters

str(glengths)  #summary and describes the elements in an object
str(species)   #summary and description of the elements in an object

lengths <- c(glengths, 90)        # adding at the end 
lengths <- c(30, glengths)        # adding at the start
lengths
# the answer will be 30.0 4.6 3000.0 50000.0

# note all the elements in a vector have to be the same type (i.e., all numbers or all text)
length_species <- c(4.5, "ecoli") #this converts a textual representation of the number --> "4.5"
length_species

# This automatic conversion is called 'coercion' or 'casting' ..

# and there are other types as well ...
sqrt_of_minus_one <- 1i
true_or_false_value <- TRUE
decimal_number <- 54.0
whole_number <- -54L

                                  #VH:use < - to assign values to an objects; use = when you assign a value to a parameter

class(sqrt_of_minus_one)
class(true_or_false_value)
class(whole_number)
class(decimal_number)

# --------
# Exercise
# --------
#
# We’ve seen that vectors can be of type character, 
# numeric (or double), integer, and logical. 
#
# But what happens if we try to mix these types in a single vector?
#
# eg:
#
#   thing <- c("some characters", 3.141, 100, TRUE)
#   thing
#   class(thing)
#
# What will happen in each of these examples?
#
  num_char <- c(1, 2, 3, "a") #class is character because of "a" 
  num_logical <- c(1, 2, 3, TRUE) #class is numeric
  char_logical <- c("a", "b", "c", TRUE) #class is character, true value is changed to character
  tricky <- c(1, 2, 3, "4") #class is character because of "4" --> written as a text
#
# [Hint: use class() to check the data type of your objects]
#
# Can you explain why you think it happens?

# --------
# Exercise
# --------
# How many values in combined_logical are "TRUE" (ie character 4 characters)
# in the following example:
#   
#   num_logical <- c(1, 2, 3, TRUE)
#   char_logical <- c("a", "b", "c", TRUE)
#   combined_logical <- c(num_logical, char_logical)


#
# Topic: Subsetting vectors
# Presented by: Evan Matthews

animals <- c("mouse", "rat", "dog", "cat")
animals[2]             #if you want to get the second element, brackets is for elements
animals[c(3, 2)]       #if you want to get the third and second element, in order   

more_animals <- animals[c(1, 2, 3, 2, 1, 4)]   #this will produce a bigger list of animals, which includes elements of the previous
more_animals

# Conditional subsetting
weight_g <- c(21,   34,    39,   54,   55)
weight_g[   c(TRUE, FALSE, TRUE, TRUE, FALSE)] #will select the elements that are TRUE

weight_g > 50     #will give a logical expression for each of the element in your object
weight_g[weight_g > 50]  #will give you elements that are bigger than 50

weight_g[weight_g < 30 | weight_g > 50]  #the bar key is a pike that is equivalent to 'OR'; select elements <30 and >50

weight_g[weight_g >= 30 & weight_g == 21] 

animals <- c("mouse", "rat", "dog", "cat")
animals[animals == "cat" | animals == "rat"] # returns both rat and cat

# %in% tells you an element is part of a dataframe

animals %in% c("rat", "cat", "dog", "duck", "goat") #for all the animals, are all the animals are in this set
animals[animals %in% c("rat", "cat", "dog", "duck", "goat")] #in this animal array, give me the subset animals

# Challenge
#
# Can you explain  why 
#
#  "four" > "five" 
#
# returns TRUE?
#
# Answer: because they are all characters and not integers/ numerical, comparison is based on alphabetical


# Topic: Missing data (NA - Not Available)


heights <- c(2, 4, 4, NA, 6)
mean(heights)                       #will show NA
max(heights)                        #will show NA 
mean(heights, na.rm = TRUE)         #will omit NA
max(heights, na.rm = TRUE)          #will omit NA

#to check elements
is.na(heights)           #which elements are NA - will give logical
!is.na(heights)          #which elements are not NA - will give logical   

heights[!is.na(heights)] #another way of removing NA, this will show elements that are not NA
heights[complete.cases(heights)] #another way of removing NA, this will show elements that are not NA and print

#this is the most efficient???
na.omit(heights)         #another way of removing NA, this will show elements that are not NA


# Exercise (extended)
#
#
# Using this vector of heights in inches, create a new vector 
# with the NAs removed.
# 
heights <- c(63, 69, 60, 65, NA, 68, 61, 70, 61, 59, 64, 69, 63, 63, NA, 72, 65, 64, 70, 63, 65)

#
# Solution

na.omit(heights)


# Use the function median() to calculate the median of the heights vector.
#
# Solution

median(na.omit(heights))
median(heights, na.rm= TRUE)


# Use R to figure out how many people in the set are taller than 67 inches.
# [Hint: R has a builtin function called length() that tells you 
# how many values are in a vector

sort (heights, decreasing = FALSE) #sorts data in increasing order
sort (heights, decreasing = TRUE)  #sorts data in decreasing order

#hi_height <- is.na(heights) > 67
