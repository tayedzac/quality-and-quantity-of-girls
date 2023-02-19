#### Preamble ####
# Purpose: Tests the properties of our data set.
# Author: Jueun Kang, Joyce Xuan, and Tayedza Chikumbirike
# Data: 18 February 2023
# Contact: jueun.kang@mail.utoronto.ca, joyce.xuan@mail.utoronto.ca, t.chikumbirike@mail.utoronto.ca
# Pre-requisites: N/A
# Any other information needed? N/A


#### Workspace setup ####
library(haven)
library(janitor)
library(tidyr)
library(tidyverse)
library(dplyr)

#### Test data ####  
# simulated data 1
simulated_data <-
  tibble(
    "year" = 1996:2001,
    "imported_ultrasound" = sample(c(933, 1256, 674, 547, 1550, 806),
                                   size = 6,
                                   replace = TRUE))

simulated_data <- simulated_data |>
  add_column("ultrasound_birth" = sample(c(0.983, 0.762, 0.321, 0.452, 0.663, 0.821)))

# test for simulated data 1

simulated_data$year |> 
  min() == 1996

simulated_data$year |> 
  max() == 2001

simulated_data$imported_ultrasound |>
  class() == "numeric"

# simulated data 2

simulated_data_2 <-
  tibble(
    "year" = 1975:2005,
    "Number of second children who are girls" = sample(c(1424, 624, 1268, 1384, 933, 1256, 674, 547,
                                                         1510, 1550, 806, 777, 1619, 1076, 1138, 644,
                                                         701, 1064, 1061, 1319, 897, 1118, 1354, 727,
                                                         569, 1049, 808, 1200, 627, 940, 573),
                                                       size = 31,
                                                       replace = TRUE))

# test for simulated data 2

simulated_data_2$year |> 
  min() == 1975

simulated_data_2$year |> 
  max() == 2005

simulated_data$year |>
  class() == "integer"