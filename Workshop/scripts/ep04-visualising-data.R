
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

#building plots iteratively

# alpha refers to transparency of the data point
# if you want to have the same colour for the data set hence the "colour"
ggplot(data = surveys_complete, mapping = aes(x = weight, y = hindfoot_length)) +
  geom_point(alpha = 0.1, colour = "blue")

# colour by specied_id
# as long as you put the details in the aesthetics, you can move the colour around
ggplot(data = surveys_complete, mapping = aes(x = weight, y = hindfoot_length)) +
  geom_point(alpha = 0.1, aes(colour = species_id))

ggplot(data = surveys_complete, mapping = aes(x = weight, y = hindfoot_length, colour = species_id)) +
  geom_point(alpha = 0.1)


# Challenge 3
# Use what you just learned to create a scatter plot of weight over species_id 
# with the plot_type showing in different colours. 
ggplot(data = surveys_complete, mapping = aes(x = species_id, y = weight)) +
  geom_point(alpha = 0.1, aes(colour = plot_type))

# adds jittering so that points don't overlap
# added another datalayer for the aesthetic
ggplot(data = surveys_complete, mapping = aes(x = species_id, y = weight)) +
  geom_jitter(alpha = 0.2, aes(colour = plot_type))


# creating boxplots
# for one discreet and one continuous data 
ggplot(data = surveys_complete, mapping = aes(x = species_id, y = weight)) +
  geom_boxplot()

# let's make it pretty
ggplot(data = surveys_complete, mapping = aes(x = species_id, y = weight)) +
  geom_boxplot(alpha = 0) +
  geom_jitter(alpha = 0.5, colour = "tomato")

# Challenge 4
# Notice how the boxplot layer is behind the jitter layer? 
# What do you need to change in the code to put the boxplot in front of the points such that it’s not hidden?
# Re-order, because the order of the layers matters in the code
ggplot(data = surveys_complete, mapping = aes(x = species_id, y = weight)) +
  geom_jitter(alpha = 0.5, colour = "tomato") +
  geom_boxplot(alpha = 0) 

# Challenge 5
# Boxplots are useful summaries but hide the shape of the distribution. 
# For example, if there is a bimodal distribution, it would not be observed with a boxplot.
# An alternative to the boxplot is the violin plot (sometimes known as a beanplot),
# where the shape (of the density of points) is drawn.
# Replace the box plot with a violin plot

ggplot(data = surveys_complete, mapping = aes(x = species_id, y = weight)) +
    geom_violin(alpha = 0, colour = "tomato") 

# Challenge 6
# So far, we’ve looked at the distribution of weight within species.
# Make a new plot to explore the distribution of hindfoot_length within each species.
# Add color to the data points on your boxplot according to the plot from which the sample was taken (plot_id).

# This shows plot_id as a gradient
ggplot(data = surveys_complete, mapping = aes(x = species_id, y = hindfoot_length)) +
  geom_jitter(alpha = 0.1, aes(colour = plot_id)) +
  geom_boxplot(alpha = 0)

# So need to change plot_id as a factor
class(surveys_complete$plot_id)

surveys_complete$plot_id <- as.factor(surveys_complete$plot_id)

head(surveys_complete)

class(surveys_complete$plot_id)

# Running again
ggplot(data = surveys_complete, mapping = aes(x = species_id, y = hindfoot_length)) +
  geom_jitter(alpha = 0.1, aes(colour = plot_id)) +
  geom_boxplot(alpha = 0)



# Challenge 7
# In many types of data, it is important to consider the scale of the observations. 
# For example, it may be worth changing the scale of the axis to better distribute 
# the observations in the space of the plot. Changing the scale of the axes is done
# similarly to adding/modifying other components (i.e., by incrementally adding commands). 
# Make a scatter plot of species_id on the x-axis and weight on the y-axis with a log10 scale.

challenge7 <- ggplot(data = surveys_complete, mapping = aes(x = species_id, y = weight)) +
  geom_jitter(alpha = 0.1, aes(colour= plot_id))

challenge7 +
scale_y_continuous(trans='log10') 

ggplot(surveys_complete, aes(species_id, weight))+
  geom_jitter(alpha = 0.1, aes(plot_id))+
  scale_y_log10()


# Plotting time series data
# counts per year for each genus 

yearly_counts <- surveys_complete %>% 
  count(year, genus)

yearly_counts

# this shows total count for all 
ggplot(data = yearly_counts, mapping = aes(x=year, y=n))+
  geom_line()

# this will show different lines for different genus
ggplot(data = yearly_counts, mapping = aes(x=year, y=n, group = genus))+
  geom_line()

# Challenge 8
# Modify the code for the yearly counts to colour by genus so we can
# clearly see the counts by genus.
# colour the different lines per genus

ggplot(data = yearly_counts, mapping = aes(x=year, y=n, colour = genus))+
  geom_line()

# Integrating the pipe operator with ggplot 
# Remember pipes ( %>% ) are different from (+)

yearly_counts %>% 
  ggplot(mapping = aes(x = year, y = n, colour = genus)) +
  geom_line()

yearly_counts_graph <- surveys_complete %>%
  count(year, genus) %>% 
  ggplot(mapping = aes(x = year, y = n, color = genus)) +
  geom_line()

yearly_counts_graph

# Faceting, making a panel of graphs to see everyone
# Basic faceting

ggplot(data = yearly_counts, mapping = aes (x = year, y = n)) +
  geom_line()+
  facet_wrap(facets = vars(genus))

ggplot(data = yearly_counts, mapping = aes (x = year, y = n)) +
  geom_line()+
  facet_wrap(~genus)

# What if we want to plot more data
# Include sex in the counts
# Will plot timeseries counts per genus and sex
yearly_sex_counts <- surveys_complete %>% 
  count(year, genus, sex)

yearly_sex_counts %>% 
  ggplot(mapping = aes (x = year, y = n, colour = sex))+
  geom_line()+
  facet_wrap(~genus)


# We want to have a grid
# Display the graphs by sex in the rows & genus in the columns
yearly_sex_counts %>% 
  ggplot(mapping = aes (x = year, y = n, colour = sex))+
  geom_line()+
  facet_grid(rows = vars(sex), cols = vars(genus))

# Display the graphs by rows for each rows
yearly_sex_counts %>% 
  ggplot(mapping = aes (x = year, y = n, colour = sex))+
  geom_line()+
  facet_grid(rows = vars(genus))

  
# Challenge 9
# How would you modify this code so the faceting is 
# organised into only columns instead of only rows?

yearly_sex_counts %>% 
  ggplot(mapping = aes (x = year, y = n, colour = sex))+
  geom_line()+
  facet_grid(cols = vars(genus))


# Customising your plots
# Changing positions of legends, changing fonts etc. 

# Using themes - preset plot themes in R 

ggplot(data = yearly_sex_counts, mapping = aes(x = year, y = n, colour = sex)) + 
  geom_line()+
  facet_wrap(~genus) +
  theme_bw()

# there is ggthemes package for more ggplot themes
# theme_classic()
# theme_void()
# theme_light()


# Challenge 10
#
# Put together what you’ve learned to create a plot that depicts how the 
# average weight of each species changes through the years.
# Hint: need to do a group_by() and summarize() to get the data
# before plotting

yearly_species_weights <- surveys_complete %>% 
  filter(!is.na(weight)) %>%                      # can remove NA
  group_by(year, species_id) %>% 
  summarise(mean_weight=mean(weight))             # or to remove NA add ,na.rm=TRUE

yearly_species_weights %>% 
  ggplot(mapping = aes (x = year, y = mean_weight))+
  geom_line()+
  facet_wrap(~species_id)+
  theme_light()

# Customisation

yearly_sex_counts %>% 
  ggplot(mapping = aes (x = year, y = n, colour = sex))+
  geom_line()+
  facet_wrap(~genus)+
  labs(title = "Observed genera through time",
       x= "Year of observation", 
       y= "Number of individuals") +
  theme_bw()+
  theme(text = element_text(size = 16), 
        axis.text.x = element_text(colour = "grey20",
                                   size = 12,
                                   angle = 90,
                                   hjust = 0.5,
                                   vjust = 0.5,),
        axis.text.y = element_text(colour = "grey20",
                                   size = 12),
        strip.text = element_text(face="italic"))


# Saving your theme
grey_theme <- theme(text = element_text(size = 16), 
                    axis.text.x = element_text(colour = "grey20",
                                               size = 12,
                                               angle = 90,
                                               hjust = 0.5,
                                               vjust = 0.5,),
                    axis.text.y = element_text(colour = "grey20",
                                               size = 12),
                    strip.text = element_text(face="italic"))


# Plot a graph using your saved theme
yearly_sex_counts %>% 
  ggplot(mapping = aes (x = year, y = n, colour = sex))+
  geom_line()+
  facet_wrap(~genus)+
  labs(title = "Observed genera through time",
       x= "Year of observation", 
       y= "Number of individuals") +
  theme_bw()+
  grey_theme

# Exporting plots, use the console so you can adjust the resolution instead of using Export in RStudio

ggsave("figures/my_plot.png", width = 15, height = 10, dpi = 300)

ggsave("figures/my_plot.pdf", width = 15, height = 10, dpi = 300)

