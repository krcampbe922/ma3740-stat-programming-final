# Infant Formula Pricing Analysis across Rural Retailers
**Michigan Technological University**

**Course:** MA3740 - Statistical Programming and Analysis

**Authors:** krcampbe, aicasab

## Project Overview
This study evaluates infant formula unit pricing (USD per ounce) across four primary retail stores in the rural communities of **Houghton and Hancock, Michigan** (Walmart, Walgreens, Pat's, and Tadych's).
The goal of this project is to determine whether unit costs vary significantly based on **store location**, **store type** (big-box chain vs. local grocer), or **formula classification** (regular vs. specialty formula).

## Key Findings & Summary
* **No Statistically Significant Price Differences Across Stores:** Neither paired $t$-tests (after Bonferroni correction for multiple comparisons) nor repeated-measures ANOVA revealed statistically significant differences in price per ounce across the four retailers.
* **Chain vs. Local Practical Trends:** Chain stores averaged **$1.39/oz** compared to local stores at **$2.09/oz** (a practical savings of ~$0.16/oz, though not statistically significant due to sample size constraints).
* **Specialty Formula Premium:** Specialty formulas averaged **$0.27/oz** higher than regular formulas across retailers.
* **Takeaway for Rural Families:** Within this localized dataset, shopping at a specific store in the Houghton/Hancock area does not guarantee statistically significant savings, though underlying practical trends exist between retailer types and product formulas.

## Statistical Methodology & Workflow
This project utilizes a structured pipeline written in R to assess differences while verifying statistical assumptions.
