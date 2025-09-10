# CrossCarry <img src="https://cran.r-project.org/Rlogo.svg" width="35" align="right" />

[![CRAN status](https://www.r-pkg.org/badges/version/CrossCarry)](https://CRAN.R-project.org/package=CrossCarry)
[![CRAN downloads](https://cranlogs.r-pkg.org/badges/grand-total/CrossCarry)](https://CRAN.R-project.org/package=CrossCarry)
[![R-CMD-check](https://github.com/Cruzalirio/CrossCarry/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/Cruzalirio/CrossCarry/actions/workflows/R-CMD-check.yaml)
[![Codecov test coverage](https://codecov.io/gh/Cruzalirio/CrossCarry/branch/main/graph/badge.svg)](https://app.codecov.io/gh/Cruzalirio/CrossCarry)

## Installation

You can install the stable release from CRAN:

```r
install.packages("CrossCarry")
```

Or the development version from GitHub:

```r
# install.packages("remotes")
remotes::install_github("Cruzalirio/CrossCarry")
```

---

## Basic Example

The package provides tools to analyze crossover designs with carry-over effects using Generalized Estimating Equations (GEE).

```r
library(CrossCarry)
data("Arterial")

# Create carry-over dummies
cc <- createCarry(data = Arterial, treatment = "Treatment", 
                  period = "Period", id = "Subject", carrySimple = TRUE)

# Fit a basic GEE model
fit <- CrossGEE(response = "Pressure", treatment = "Treatment", 
                period = "Period", id = "Subject", 
                carry = cc$carryover, data = cc$data,
                correlation = "AR-M", Mv = 1)

# Print model QIC criteria
fit$QIC
```

---

## Citation

If you use **CrossCarry**, please cite the methodological papers:

- Cruz, N.A., et.al. (2023).  
  *Semiparametric generalized estimating equations for repeated measurements in cross-over designs*.  
  Statistical Methods in Medical Research. [DOI link](https://doi.org/10.1177/09622802231158736)

- Cruz, N.A., et al. (2024).  
  *A correlation structure for the analysis of Gaussian and non-Gaussian responses in crossover experimental designs with repeated measures*.  
  Statistical Papers. [DOI link](https://link.springer.com/article/10.1007/s00362-022-01391-z)
  
- Cruz, N.A., et al. (2023).  
  *Analysis of cross-over experiments with count data in the presence of carry-over effects*.  
  Statistica Neerlandica. [DOI link](https://doi.org/10.1111/stan.12295)
    
- Cruz, N.A., et al. (2025).  
  *Penalized GEE for Complex Carry-Over in Repeated-Measures Crossover Designs*.  
  (preprint / in review). [DOI link](https://doi.org/10.48550/arXiv.2402.16362)

You can also obtain the citation directly in R:

```r
citation("CrossCarry")
```

---

## Applications

CrossCarry has been applied in different contexts:

- **Biomedical trials**: estimation of treatment and carry-over effects in blood pressure crossover studies.
- **Nutrition and cognition**: water supplementation trial in schoolchildren.
- **Software experiments**: estimation of learn rates in programming students. 
- **Methodological research**: simulation studies comparing correlation structures in GEE.
- **Ongoing work**: penalized GEE for spline-based carry-over effects, with applications in pharmacology.

---
