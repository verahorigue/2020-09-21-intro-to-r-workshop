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
# note that a data frame cannot just have one column

surveys[1]                             #this selects the first column as a data frame, just one column data
head(surveys[1])                       #shows the head of the first column as a data frame, as a column
head(surveys[,1])                      #shows the head of the first column as a row

# first three columns of the data frame (as a data frame)
sel_surveys <- surveys[,1:3]           # this automatically saves the subset as a dataframe
head(sel_surveys) 


# first row (as a data frame)
surveys[1,]

# first three elements in the 7th column (as a vector)
surveys[1:3, 7]

# the 3rd row of the data frame (as a data.frame)

surveys[3,]

# equivalent to head(surveys)

head(surveys)
surveys[1:6,]

# looking at the 1:6 more closely -- shorthand for a range in sequence

1:6
5:10
surveys[c(1,2,3,4,5,6),] # select first six rows
surveys[c(2,4,6,8),]     # select even rows

# we also use other objects to specify the range

rows <- 6
surveys[1:6, 3]
surveys[1:rows, 3]

#
# Challenge: Using slicing, see if you can produce the same result as:
#
#tail(surveys)
#surveys[5]                             #this selects the first column as a data frame, just one column data
#tail(surveys[5])                       #shows the head of the first column as a data frame, as a column
#tail(surveys[,5])                      #shows the head of the first column as a row

# i.e., print just last 6 rows of the surveys dataframe
#
# Solution:
nrow(surveys)                    # will show you the number of rows
surveys[34781:nrow(surveys),]    # you can use nrow as the last number
surveys[(nrow(surveys)-5):nrow(surveys),]    #but since you don't know the range until the last row, get the last row and the
                                              #first five rows before it to make it as 6 rows

# this is a cleaner and shorter version of the code above
end <- nrow(surveys)
surveys[(end-5):end,]


# We can omit (leave out) columns using '-'-- minus sign
surveys[-1]            #give me everything except the first column

surveys[c(-1,-2,-3)]   #give me everything except the first three columns
head(surveys[c(-1,-2,-3)] )
head(surveys[c(-2,-3, -4)] ) # gives back the record id
head(surveys[-(1:3)]) # negates the first three columns, if you want to omit columns in sequence

-1:3 # is not the same as -(1:3)


# column "names" can be used in place of the column numbers

surveys["month"]
head(surveys["month"])

#
# Topic: Factors (for categorical data)
#
# Examples:
# ranking - high, medium, low;
# gender - male, female;
# Likert scales - very likely, likely, neutral
# Country - Australia, New Zealand, australia -- this one is an error because of the capitals

gender <- c("male", "male", "female")
gender <- factor(c("male", "male", "female"))
gender

class(gender)
levels(gender)
nlevels(gender)

# factors have an order  --- this will be printed alphabetically
temperature <- factor(c("hot", "cold", "hot", "warm"))
temperature[1] 
temperature[2] 
temperature[3] 

class(temperature)
levels(temperature)
nlevels(temperature)

# to rearrange the factors based on a different order
temperature <- factor(c("hot", "cold", "hot", "warm"), level = c("cold", "warm", "hot"))
levels(temperature)

# Converting factors

as.numeric(temperature)      #this will convert the factors into numbers, but you won't remember what these are
as.character(temperature)    #this will convert the factors into strings

# can be tricky if the levels are numbers

year <- factor(c(1990, 1983, 1977, 1998, 1990))
year
as.numeric(year)                      #this will save the factors as a set of numbers that don't really make sense
as.character(year)                    #this will save the factors as characters (numbers as text) that you can't use for calcs
as.numeric(as.character(year))        #this will save the factors as a number and character, which you can use for calcs

# so does our survey data have any factors?

str(surveys)    #will tell you which variables are factors


### Topic:  Dealing with Dates

# R has a whole library for dealing with dates ...

library(lubridate)    #install the package to deal with dates

my_date <- ymd("2015-01-01")    #ymd -- year month date function
class(my_date)

# date: 7-16-1977 --> create this by pasting three columns together

# R can concatenate things together using paste()

paste("abc", "123", "xyz")
paste("abc", "123", "xyz", sep= "+")  #adds a plus symbol for the separator
paste("abc", "123", "xyz", sep= "-")  #adds a hyphen for the separator
paste("2015", "01", "26", sep= "-")

my_date <- ymd(paste("2015", "01", "26", sep= "-"))    #ymd -- year month date function
class(my_date)

# 'sep' indicates the character to use to separate each component

# paste() also works for entire columns

paste(surveys$year, surveys$month, surveys$day, sep="-")

# let's save the dates in a new column of our dataframe surveys$date 
# this creates a new column and use lubridate to paste the three columns together

surveys$date <- ymd(paste(surveys$year, surveys$month, surveys$day, sep="-"))

# and ask summary() to summarise 
summary(surveys)

# but what about the "Warning: 129 failed to parse"
# some data couldn't be converted to a date because it was indicated as NA

summary(surveys$date)

# find the rows that have NAs in the data.frame

is.na(surveys$date)
missing_dates <- surveys[is.na(surveys$date), "date"]
missing_dates

# the data entries could not be converted because some of the months don't have 31 days
missing_dates <- surveys[is.na(surveys$date), c("record_id", "year", "month", "day")]
summary(missing_dates)                         
