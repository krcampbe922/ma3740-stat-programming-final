# load data and libraries
data <- read.csv("data.csv", header = TRUE)
library(afex)
library(patchwork)
library(tidyverse)
library(ggplot2)

# create price per ounce column
data <- data %>% 
  mutate(Price_Per_Oz = Price / Size)
