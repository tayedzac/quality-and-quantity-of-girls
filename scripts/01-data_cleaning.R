#### Preamble ####
# Purpose: Cleans two sets of raw data to accomodate our 3 claims.
# Author: Jueun Kang, Joyce Xuan, and Tayedza Chikumbirike
# Data: 9 February 2023
# Contact: jueun.kang@mail.utoronto.ca, joyce.xuan@mail.utoronto.ca, t.chikumbirike@mail.utoronto.ca
# Pre-requisites: Download the raw data files to your device.
# Any other information needed? N/A

#### Workspace setup ####
library(haven)
library(janitor)
library(tidyr)
library(tidyverse)
library(dplyr)

#### Clean data ####

# Claim 1 Data - Cleaning

read_ultrasound_data <- read_dta("~/INF312/ultrasound_produc_summary.dta")

clean_data <- clean_names(read_ultrasound_data) |>
  select(
    startyear,
    ultrasoundscanner,
    ults_pct
  ) |>
  drop_na(ultrasoundscanner) |>
  drop_na(ults_pct) |>
  mutate(changed_column = ultrasoundscanner / 10000) |>
  rename(
    year = startyear,
    imported_ultrasound = ultrasoundscanner,
    ultrasound_birth = ults_pct
  )

# Claim 2 Data - Cleaning

india_postbirth <- read_dta("~/INF312/clusterings_india_postbirth_allb_full_sample.dta")

clean_data_total <- clean_names(india_postbirth) |>
  filter(bord == "1") |>
  select(
    yearc,
    femalec,
    bord
  ) |>
  drop_na(
    yearc,
    femalec,
    bord
  ) |>
  group_by(yearc) |>
  summarise(sum_total = sum(bord))

clean_data_girl <- clean_names(india_postbirth) |>
  filter(
    femalec == "1",
    bord == "1") |>
  select(
    yearc,
    femalec,
    bord
  ) |>
  drop_na(
    yearc,
    femalec,
    bord
  ) |>
  group_by(yearc) |>
  summarise(sum_first_girl = sum(femalec))

clean_data_2 <- merge(clean_data_total, clean_data_girl)

# Claim 3 Data - Cleaning

read_india_postbirth <- read_dta("~/INF312/clusterings_india_postbirth_allb_full_sample.dta")

clean_data_3 <- clean_names(read_india_postbirth) |>
  filter(
    femalec == "1",
    bord == "2",
    girl1 == "1") |>
  select(
    yearc,
    femalec,
    bord,
    girl1
  ) |>
  drop_na(yearc,
          femalec,
          bord,
          girl1
  ) |>
  group_by(yearc) |>
  summarise(sum_second_girl = sum(femalec))

#### Save data ####

# Claim 1 Data - Saving

write_csv(clean_data, "~/qual-and-quant-of-girls/inputs/data/clean_data.csv")

# Claim 2 Data - Saving

write_csv(clean_data_2, "~/qual-and-quant-of-girls/inputs/data/clean_data_2.csv")

# Claim 3 Data - Saving

write_csv(clean_data_3, "~/qual-and-quant-of-girls/inputs/data/clean_data_3.csv")