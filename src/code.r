# Author: Carl Hatoum
# Date: 29/12/2019


# Libraries

library(corrplot)
library(ggplot2)
library(tidyverse)
library(hrbrthemes)
library(viridis)
library(forcats)

# Load dataset from github

data <- read.csv("https://raw.githubusercontent.com/CarlHatoum/Spotify-TOP-50-songs/master/top50.csv")

# Select only numerical variables

filtered_data = data[,c(5:14)]

# Plot histograms

 filtered_data <- filtered_data %>%
+   gather(key="text", value="value") %>%
+   mutate(text = gsub("\\.", " ",text)) %>%
+   mutate(value = round(as.numeric(value),0))

p <- filtered_data %>%
mutate(text = fct_reorder(text, value)) %>%
ggplot( aes(x=value, color=text, fill=text)) +
geom_histogram(alpha=0.6, binwidth = 5) +
scale_fill_viridis(discrete=TRUE) +
scale_color_viridis(discrete=TRUE) +
theme_ipsum() +
theme(legend.position="none", panel.spacing = unit(0.1, "lines"), strip.text.x = element_text(size = 8)) +
xlab("") +
ylab("") +
facet_wrap(~text)

# Plotting correlation matrix

mtCor <- cor(filtered_data)
corrplot(mtCor, method = "number", type = "upper")

# Plotting two pairs of correlated variables

head(data)
ggplot(data, aes(x=Energy, y=Loudness..dB.., color=Genre))+geom_point()
ggplot(data, aes(x=Beats.Per.Minute, y=Speechiness., color=Genre))+geom_point()
