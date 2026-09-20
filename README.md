# Dietary Intake and Cardiometabolic Risk in US Adults: A Bayesian Analysis of NHANES 2017–2018

**Status:** In progress | **Data:** NHANES 2017–2018 | **Tools:** R, brms, tidyverse

---

## Overview

This project investigates whether dietary intake patterns — specifically sugar and saturated fat consumption — are associated with cardiometabolic risk markers (BMI and waist circumference) in US adults.

Using the National Health and Nutrition Examination Survey (NHANES) 2017–2018 cycle, I apply a Bayesian regression framework (via `brms`) to model the relationship between dietary variables and body composition outcomes, accounting for key demographic confounders including age, sex, and income-to-poverty ratio.

This builds directly on the hierarchical Bayesian modelling approach I used in my MSc thesis (*Geospatial Analysis of COVID-19 Vaccination Uptake across Ireland's 166 LEAs*, University of Galway, 2025), extending it from a public health context into nutritional epidemiology.

---

## Research Questions

1. Are higher intakes of total sugars and saturated fat associated with elevated BMI in US adults?
2. Does waist circumference show a stronger association with dietary fat intake than BMI alone?
3. Do these associations differ by sex or age group?

---

## Data Sources

All data are publicly available from the CDC NHANES portal:

| Component | NHANES Code | Variables Used |
|-----------|-------------|----------------|
| Dietary Intake (Day 1) | DR1TOT_J | Total sugar, saturated fat, total energy |
| Body Measures | BMX_J | BMI, waist circumference |
| Demographics | DEMO_J | Age, sex, income-to-poverty ratio |

Data are accessed via the `nhanesA` R package — no manual download required.

**A note on dataset choice:** The ideal dataset for this analysis in an Irish context would be the **National Adult Nutrition Survey (NANS, 2008–2010)**, run by the Irish Universities Nutrition Alliance (IUNA) at UCD. NANS provides detailed dietary intake data for Irish adults and would allow findings directly applicable to Irish public health policy. However, NANS is not publicly available — access requires a formal data request to IUNA, which is outside the scope of this portfolio project.

NHANES was selected as a methodologically equivalent, fully open-access alternative. It follows the same dietary recall methodology, covers a comparable adult population, and is the standard reference dataset in nutritional epidemiology research globally. The statistical methods demonstrated here transfer directly to NANS or any comparable national nutrition survey.

---

## Methods

- **Design:** Cross-sectional observational analysis at the individual level
- **Models:** Bayesian linear regression using `brms` (R interface to Stan)
- **Priors:** Weakly informative priors; sensitivity analysis planned
- **Confounders:** Age, sex, income-to-poverty ratio
- **Stratification:** By sex and age group (18–44, 45–64, 65+)

---

## Repo Structure
.
├── R/
│   ├── 01_data_pull.R        # NHANES data extraction and merge
│   ├── 02_eda.R              # Exploratory data analysis
│   ├── 03_models.R           # Bayesian regression models
│   └── 04_visualisation.R    # Marginal effects and posterior plots
├── output/                   # Figures and model summaries
├── docs/                     # Analysis report (Quarto/R Markdown)
└── README.md

---

## Current Progress

- [x] Repo initialised
- [x] Data pull script written
- [x] EDA script written
- [ ] Models fit
- [ ] Report rendered

---

## About

**Ramya Sri Jayashanker Chithra**
MSc Health Data Science, University of Galway (2025)
[GitHub](https://github.com/ramya-sjc) | [LinkedIn](https://www.linkedin.com/in/ramya-sri-jayashanker/)

*Interested in nutritional epidemiology and the application of Bayesian statistical methods to food and health research.*
