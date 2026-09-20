#01_data_pull.R
#NHANES 2017-2018: Pull dietary, body measures, and demographics data
#Author: Ramya Sri Jayashanker Chithra

library(nhanesA)
library(tidyverse)

#1. Pull each component from NHANES 2017-2018 (cycle suffix: _J)

#Dietary Recall Day 1 (Total Nutrients)
dietary_raw <- nhanes("DR1TOT_J")

dietary <- dietary_raw %>%
  select(
    SEQN,                  #Respondent ID
    DR1TKCAL,              #Total energy (kcal)
    DR1TSUGR,              #Total sugars (g)
    DR1TSFAT,              #Total saturated fat (g)
    DR1TTFAT,              #Total fat (g)
    DR1TPROT,              #Total protein (g)
    DR1TCARB               #Total carbohydrates (g)
  ) %>%
  rename(
    energy_kcal   = DR1TKCAL,
    sugar_g       = DR1TSUGR,
    sat_fat_g     = DR1TSFAT,
    total_fat_g   = DR1TTFAT,
    protein_g     = DR1TPROT,
    carb_g        = DR1TCARB
  )

cat("Dietary rows pulled:", nrow(dietary), "\n")

#Body Measures
body_raw <- nhanes("BMX_J")

body <- body_raw %>%
  select(
    SEQN,
    BMXBMI,    #BMI
    BMXWAIST   #Waist circumference (cm)
  ) %>%
  rename(
    bmi            = BMXBMI,
    waist_cm       = BMXWAIST
  )

cat("Body measures rows pulled:", nrow(body), "\n")

#Demographics
demo_raw <- nhanes("DEMO_J")

demo <- demo_raw %>%
  select(
    SEQN,
    RIAGENDR,   #Sex (1 = Male, 2 = Female)
    RIDAGEYR,   #Age in years
    INDFMPIR,   #Income-to-poverty ratio
    RIDRETH3    #Race/ethnicity
  ) %>%
  rename(
    sex              = RIAGENDR,
    age              = RIDAGEYR,
    income_pov_ratio = INDFMPIR,
    ethnicity        = RIDRETH3
  ) %>%
  mutate(
    sex = factor(sex, levels = c(1, 2), labels = c("Male", "Female")),
    age_group = case_when(
      age >= 18 & age <= 44 ~ "18-44",
      age >= 45 & age <= 64 ~ "45-64",
      age >= 65              ~ "65+",
      TRUE                   ~ NA_character_
    ),
    age_group = factor(age_group, levels = c("18-44", "45-64", "65+"))
  )

cat("Demographics rows pulled:", nrow(demo), "\n")

#2. Merge and clean

nhanes_merged <- dietary %>%
  inner_join(body, by = "SEQN") %>%
  inner_join(demo, by = "SEQN") %>%
  filter(
    age >= 18,           #Adults only
    !is.na(bmi),
    !is.na(waist_cm),
    !is.na(sugar_g),
    !is.na(sat_fat_g),
    !is.na(energy_kcal),
    !is.na(income_pov_ratio),
    bmi < 70             #Remove implausible BMI values
  )

cat("Final merged dataset rows:", nrow(nhanes_merged), "\n")
cat("Variables:", ncol(nhanes_merged), "\n")
glimpse(nhanes_merged)

#3. Save

saveRDS(nhanes_merged, "D:/Documents/Project-Portfolio/Dietry-Cardiometabolic-Bayes/nhanes_clean.rds")
write_csv(nhanes_merged, "D:/Documents/Project-Portfolio/Dietry-Cardiometabolic-Bayes/nhanes_clean.csv")

cat("\nData saved to output/nhanes_clean.rds and output/nhanes_clean.csv\n")
