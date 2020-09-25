
###### VISUALISING DATA WITH GGPLOT2


### load ggplot2

installed.packages()
install.packages("ggplot2")
library(ggplot2)     
#library("ggplot2")  #no need to use quotation marks, because R already recognises it in the system

library(tidyverse)

surveys_complete <- read_csv("data_raw/surveys_complete.csv")
str(surveys_complete)


### create a plot


# tell ggplot the data and then shows a blank plot, needs more info
ggplot(data = surveys_complete) 

# puts the aesthetics (contents), will show the axes but no values
ggplot(data = surveys_complete, mapping = aes(x = weight, y = hindfoot_length))

# adds values, basic scatter plot
ggplot(data = surveys_complete, mapping = aes(x = weight, y = hindfoot_length)) +
  geom_point()

# assign a plot to an object
# note that the aesthetics will only be included within what's included in the parenthesis
surveys_plot <- ggplot(data = surveys_complete, mapping = aes(x = weight, y = hindfoot_length)) 
surveys_plot

# draw the plot
# using the object above you can add other commands afterwards
surveys_plot +
  geom_point()

# swap the values for the x and y axes
surveys_scatter <- ggplot(data = surveys_complete, mapping = aes(x = hindfoot_length, y = weight)) 

surveys_scatter + 
  geom_point()

# other option
surveys_scatter + 
  geom_point(aes(x = hindfoot_length, y = weight))

# create a histogram
surveys_histogram <- ggplot(data = surveys_complete, mapping = aes(weight)) 

surveys_histogram +
  geom_histogram()

surveys_histogram +
  geom_histogram(binwidth = 10)





