#####################
# MANIPULATING DATA #
#       using       #
#     TIDYVERSE     #
#####################
#
#
# Based on: https://datacarpentry.org/R-ecology-lesson/03-dplyr.html

# Data is available from the following link (we should already have it)
download.file(url = "https://ndownloader.figshare.com/files/2292169",
              destfile = "data_raw/portal_data_joined.csv")

#---------------------
# Learning Objectives
#---------------------

# Describe the purpose of the dplyr and tidyr packages.
# Select certain columns in a data frame with the dplyr function select.
# Select certain rows in a data frame according to filtering conditions with the dplyr function filter .
# Link the output of one dplyr function to the input of another function with the ‘pipe’ operator %>%.
# Add new columns to a data frame that are functions of existing columns with mutate.
# Use the split-apply-combine concept for data analysis.
# Use summarize, group_by, and count to split a data frame into groups of observations, apply summary statistics for each group, and then combine the results.
# Describe the concept of a wide and a long table format and for which purpose those formats are useful.
# Describe what key-value pairs are.
# Reshape a data frame from long to wide format and back with the pivit_wider and pivit_longer commands from the tidyr package.
# Export a data frame to a .csv file.
#----------------------


#------------------
# Lets get started!
#------------------

install.packages("tidyverse")
library(tidyverse)
# dplyr and tidyr

# Load the dataset
surveys <- read_csv("data_raw/portal_data_joined.csv")
View(surveys)

# Check the structure of the dataset
str(surveys)


#-----------------------------------
# Selecting columns & filtering rows
#-----------------------------------
select(surveys, plot_id, species_id, weight)    #select these three columns

#showed some errors, so doing it differently

select(surveys, -record_id, -species_id)        #select columns except these two columns

#Filter for a particular year

filter(surveys, year == 1995)                   #similar to select, but it's filtering and will show you all the 1995 data

surveys_1995 <- filter(surveys, year == 1995)

surveys2 <- filter(surveys, weight<5)
surveys_snl <- select(surveys2, species_id, sex, weight)

surveys_snl <- select(filter(surveys, weight <5), species_id, sex, weight) #this line does the same thing as lines 63 and 64



#-------
# Pipes
#-------

# The pipe is --> %>%
# Shortcut --> ctrl + shift + m or command + shift + m

# You don't have to keep typing your data frame anymore

surveys_snl <- surveys %>% 
  filter(weight < 5) %>% 
  select(species_id, sex, weight)

# This order can be less computationally intensive
surveys_snl2 <- surveys %>% 
  select(species_id, sex, weight)  %>% 
  filter(weight < 5)
  

#-----------
# CHALLENGE
#-----------

# Using pipes, subset the ```surveys``` data to include animals collected before 1995 and 
# retain only the columns ```year```, ```sex```, and ```weight```.


surveys_sub <- surveys %>% 
  select(year, sex, weight) %>% 
  filter(year < 1995)  


surveys_sub <- surveys %>% 
  select(year, weight, sex) %>%   #ordering your columns does matter
  filter(year < 1995)  
  


#--------
# Mutate
#--------

surveys_weights <- surveys %>% 
  mutate(weight_kg = weight/1000,
         weight_lb = weight_kg * 2.2)

surveys %>% 
  filter(weight!="") %>% 
  mutate(weight_kg = weight/1000) %>% 
  head(20)
       
surveys %>% 
  filter(!is.na(weight)) %>% 
  mutate(weight_kg = weight/1000) %>% 
  head(20)

#-----------
# CHALLENGE
#-----------

# Create a new data frame from the ```surveys``` data that meets the following criteria: 
# contains only the ```species_id``` column and a new column called ```hindfoot_cm``` containing 
# the ```hindfoot_length``` values converted to centimeters. In this hindfoot_cm column, 
# there are no ```NA```s and all values are less than 3.

# Hint: think about how the commands should be ordered to produce this data frame!

surveys_hindfoot <- surveys %>% 
  select(species_id, hindfoot_length) %>% 
  mutate(hindfoot_cm = hindfoot_length * 0.1) %>% 
  filter(!is.na(hindfoot_cm!=""), hindfoot_cm < 3)



#---------------------
# Split-apply-combine
#---------------------


surveys %>% 
  group_by(sex) %>% 
  summarise (mean_weight = mean(weight, na.rm = TRUE))

# if you have conflicting packages, so it would be good to specify

surveys %>% 
  dplyr::group_by(sex) %>% 
  summarise(mean_weight = mean(weight, na.rm = TRUE))

#surveys$sex <-as.factor(surveys$sex)

# remove NA, group and get weight by sex and species id
surveys_sex_weight <- surveys %>% 
  filter(!is.na(weight), !is.na(sex)) %>% 
  group_by(sex, species_id) %>% 
  summarise(mean_weight = mean(weight)) %>% 
  print(n=20)                           # this is similar to doing head or tail, but you're specifying how many rows to show


# to summarise data as above, and arrange by min_weight
surveys %>% 
  filter(!is.na(weight), !is.na(sex)) %>% 
  group_by(sex, species_id) %>% 
  summarise(mean_weight = mean(weight), 
            min_weight = min(weight)) %>% 
  #arrange(min_weight)                      #arrange by min_weight column
  #arrange(mean_weight)                     #arrange by mean_weight column
  #arrange(desc(min_weight))                #default arrange is ascending, so adding desc() will do descending order
  arrange(-min_weight)                      #does the same as desc()

# to summarise the data by count
surveys %>% 
  count(sex)

# this also does the same thing as above, just longer code
surveys %>% 
  group_by(sex) %>% 
  summarise(count=n())


# using group_by for multiple variables
surveys_new <- surveys %>% 
  group_by(sex, species, taxa ) %>% 
  summarise(count=n()) %>% 
  ungroup()

str(surveys_new)

surveys_new %>% 
  summarise(mean_weight = mean(weight),
            min_weight = min(weight),
            max_weight = max(weight))



#-----------
# CHALLENGE
#-----------

# 1. How many animals were caught in each ```plot_type``` surveyed?
num_animals_plot < - surveys %>% 
  count(plot_type)


# 2. Use ```group_by()``` and ```summarize()``` to find the mean, min, and max hindfoot length 
#    for each species (using ```species_id```). Also add the number of observations 
#    (hint: see ```?n```).

species_hindfoot <- surveys %>% 
  filter(!is.na(hindfoot_length)) %>% 
  group_by(species_id) %>% 
  summarise(mean_footlength = mean(hindfoot_length),
          min_footlength = min(hindfoot_length),
          max_footlength = max(hindfoot_length),
          count = n())



# 3. What was the heaviest animal measured in each year? 
#    Return the columns ```year```, ```genus```, ```species_id```, and ```weight```.

heaviest_animal <- surveys %>%    #this option returns only 2 vars don't know why
  select(year, genus, species_id, weight) %>% 
  group_by(year) %>% 
  summarise(max_weight = max(weight, na.rm = TRUE)) %>% 
  ungroup()

heaviest_animal2 <- surveys %>%   #this option returned 5 variables, all obs (didn't group)
  group_by(year) %>% 
  select(year, genus, species_id, weight) %>% 
  mutate(max_weight = max(weight, na.rm=TRUE)) %>% 
  ungroup()

heaviest_animal3 <- surveys %>%   #this worked, although one obs was repeated
  filter(!is.na(weight)) %>% 
  group_by(year) %>% 
  filter(weight == max(weight)) %>% 
  select(year, genus, species_id, weight) %>% 
  arrange(year)

heaviest_animal4 <- surveys %>%   #this worked, although one obs was repeated
  filter(!is.na(weight)) %>% 
  group_by(year) %>% 
  filter(weight == max(weight)) %>% 
  select(year, genus, species, weight) %>% 
  arrange(year)

heaviest_animal5 <-surveys %>%    #this worked, although one obs was repeated
  select(year, genus, species, weight) %>% 
  group_by(year) %>% 
  top_n(1,weight) %>% 
  arrange(year)

#-----------
# Reshaping
#-----------







#-----------
# CHALLENGE
#-----------

# 1. Spread the surveys data frame with year as columns, plot_id as rows, 
#    and the number of genera per plot as the values. You will need to summarize before reshaping, 
#    and use the function n_distinct() to get the number of unique genera within a particular chunk of data. 
#    It’s a powerful function! See ?n_distinct for more.

# 2. Now take that data frame and pivot_longer() it again, so each row is a unique plot_id by year combination.

# 3. The surveys data set has two measurement columns: hindfoot_length and weight. 
#    This makes it difficult to do things like look at the relationship between mean values of each 
#    measurement per year in different plot types. Let’s walk through a common solution for this type of problem. 
#    First, use pivot_longer() to create a dataset where we have a key column called measurement and a value column that 
#    takes on the value of either hindfoot_length or weight. 
#    Hint: You’ll need to specify which columns are being pivoted.

# 4. With this new data set, calculate the average of each measurement in each year for each different plot_type. 
#    Then pivot_wider() them into a data set with a column for hindfoot_length and weight. 
#    Hint: You only need to specify the key and value columns for pivot_wider().





#----------------
# Exporting data
#----------------












