#   _____ _             _   _                        _ _   _       _____        _        
#  / ____| |           | | (_)                      (_| | | |     |  __ \      | |       
# | (___ | |_ __ _ _ __| |_ _ _ __   __ _  __      ___| |_| |__   | |  | | __ _| |_ __ _ 
#  \___ \| __/ _` | '__| __| | '_ \ / _` | \ \ /\ / | | __| '_ \  | |  | |/ _` | __/ _` |
#  ____) | || (_| | |  | |_| | | | | (_| |  \ V  V /| | |_| | | | | |__| | (_| | || (_| |
# |_____/ \__\__,_|_|   \__|_|_| |_|\__, |   \_/\_/ |_|\__|_| |_| |_____/ \__,_|\__\__,_|
#                                    __/ |                                               
#                                   |___/                                                
#
# Based on: https://datacarpentry.org/R-ecology-lesson/02-starting-with-data.html



# Lets download some data (make sure the data folder exists)
download.file(url = "https://ndownloader.figshare.com/files/2292169",
              destfile = "data_raw/portal_data_joined.csv")

# The data is downloaded into your Rproj folder, instead of your desktop. If your desktop, the directory should be included

# now we will read this "csv" into an R object called "surveys"
surveys <- read.csv("data_raw/portal_data_joined.csv")
surveys <- read.csv("data_raw/portal_data_joined.csv", header = TRUE) # will let R know that the first row is a header

View(surveys) #views your data like a spreadsheet, first letter has to be capital

# and take a look at it



# BTW, we assumed our data was comma separated, however this might not
# always be the case. So we may been to tell read.csv more about our file.

# So what kind of an R object is "surveys" ?

class(surveys)              # R will respond and say it is a data.frame



# ok - so what are dataframes ?

str(surveys)                # will tell you the structure of the data.frame, including no. of rows, cols, etc.
dim(surveys)                # will tell you the dimension of the data.frame (i.e., x vs y)
nrow(surveys)               # will tell you the number of the rows (number of observations)
ncol(surveys)               # will tell you the number of columns (number of variables)

head(surveys, 20)           # will show you the first 20 rows
tail(surveys, 2)            # will show you the last 2 rows

names(surveys)                     # will give the headers for the columns
rownames(surveys)                  # will just give the labels (in this case are id numbers) for the rows

# --------
# Exercise
# --------
#
# What is the class of the object surveys?
#
# Answer:

data.frame 

# How many rows and how many columns are in this survey ?
#
# Answer: 34786 x 13


# What's the average weight of survey animals
#
#
# Answer: 42.67243

#Option 1 -- Most efficient, if you're familiar with R already
mean(surveys$weight, na.rm = TRUE) 

#Option 2 -- If you want to explore the dataset
summary(surveys)                   # will give you the summary statistics for each column

# Are there more Birds than Rodents? 
# From the summary, can have a look at the data already
#
# Answer:No

# Or could do
sum(surveys$taxa == "Rodent")      # Gets the sum of observations for rodents
sum(surveys$taxa == "Bird")        # Gets the sum of observations for birds


# 
# Topic: Sub-setting
#

# first element in the first column of the data frame (as a vector)
surveys[1,1]    # use brackets this time, this is x,y


# first element in the 6th column (as a vector)

surveys[1,6]

# first column of the data frame (as a vector)

surveys[,1]

# sixth column of the data frame (as a vector)

surveys[, 6]

# first column of the data frame (as a data frame)

#first_col_surveys <- surveys[,1]
#data.frame(first_col_surveys)

# first row (as a data frame)


# first three elements in the 7th column (as a vector)


# the 3rd row of the data frame (as a data.frame)


# equivalent to head(metadata)


# looking at the 1:6 more closely


# we also use other objects to specify the range



#
# Challenge: Using slicing, see if you can produce the same result as:
#
#   tail(surveys)
#
# i.e., print just last 6 rows of the surveys dataframe
#
# Solution:



# We can omit (leave out) columns using '-'



# column "names" can be used in place of the column numbers



#
# Topic: Factors (for categorical data)
#


# factors have an order


# Converting factors


# can be tricky if the levels are numbers


# so does our survey data have any factors


#
# Topic:  Dealing with Dates
#

# R has a whole library for dealing with dates ...



# R can concatenated things together using paste()


# 'sep' indicates the character to use to separate each component


# paste() also works for entire columns


# let's save the dates in a new column of our dataframe surveys$date 


# and ask summary() to summarise 


# but what about the "Warning: 129 failed to parse"


