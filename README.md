# US Housing Supply & Economic Analysis

## Project Overview
This repository contains a comprehensive quantitative research project analyzing the drivers of domestic home values in the United States from 1968 to 2019. This research, conducted as part of my Advanced Quantitative Methods coursework at the University of California, Santa Cruz (UCSC), employs multivariate regression and time-series forecasting to isolate the factors contributing to real estate price appreciation.

## Updated Methodology Note
*The quantitative analysis in this repository has been updated to reflect current modeling practices (2026). The ARIMA forecasting model now utilizes `auto.arima()` to dynamically determine optimal parameters, providing a more robust forecast. Statistical outputs, coefficients, and error metrics have been refreshed to align with the current computational environment.*

## Business Value & Economic Insights
- **Macro-Factors Outweigh Pure Supply:** My findings indicate that macroeconomic indicators—specifically CPI, Interest Yields, and Wages—are significantly stronger determinants of median home prices than new construction volume alone.
- **The Economic Growth Indicator:** While simplistic supply-side models often assume a negative correlation between supply and price, this multivariate analysis reveals a complex relationship where construction volume frequently acts as a proxy for robust economic expansion, which drives demand-side pricing.
- **Forecasting Volatility:** The analysis demonstrates the limitations of standard time-series models in accounting for extreme economic shocks (such as the COVID-19 pandemic), emphasizing the need for flexible, adaptive modeling approaches.

## Technical Stack
- **Languages:** R
- **Statistical Methods:**
  - **Ordinary Least Squares (OLS) Regression:** Used for identifying key macroeconomic predictors and quantifying their impact.
  - **ARIMA (Autoregressive Integrated Moving Average):** Employed for time-series forecasting.
  - **Lasso Regression:** Utilized for variable selection and mitigating multicollinearity.
  - **Stationarity Testing:** Augmented Dickey-Fuller (ADF) tests were used to ensure model stability.

## Quantitative Results & Model Performance

### Regression Coefficients (Multivariate OLS)
The following table summarizes the multivariate OLS regression results. Significance codes denote the statistical impact on median home prices.

| Variable | Estimate | Significance |
| :--- | :--- | :--- |
| **Intercept** | 41,180 | ** |
| avg_new_housing | 30.82 | |
| gdp | 2.34 | |
| **cpi** | 695.20 | *** |
| ca | 0.47 | |
| expenditure | -6.83 | |
| tbus | 2.33 | |
| **money** | -7.58 | * |
| **iy** | -279,500 | *** |
| **unemp** | 837.60 | *** |
| **wage** | -2,462 | *** |
| **housing_rent_rtn** | 81,140 | *** |

*Significance Codes: `***` p<0.001, `**` p<0.01, `*` p<0.05*

- **Model Fit:** The model achieved an Adjusted R-squared of 0.9985. Note: In time-series data with strong upward trends, R-squared is heavily inflated. This non-stationarity is exactly why Augmented Dickey-Fuller (ADF) tests and differencing were required for the subsequent ARIMA modeling.

### ARIMA Time-Series Forecasting
The time-series data was fitted using an `auto.arima()` approach, resulting in an **ARIMA(1,1,0)** model specification.
- **Training RMSE:** $6,520.65
- **Insight:** The inclusion of an autoregressive component effectively captured price momentum, providing a reliable baseline for time-series forecasting that outperforms basic linear trends.

## How to Run This Project
1. **Prerequisites:** Ensure [R](https://cran.r-project.org/) and [RStudio](https://posit.co/download/rstudio-desktop/) are installed.
2. **Install Dependencies:**
   Run the following in your R console:
   ```R
   install.packages(c("forecast", "glmnet", "urca", "readxl", "Metrics", "dynlm", "stargazer"))
   ```
3. **Execution:**
   - Clone the repository.
   - Run the script. The dataset is already included and referenced via a relative path (data/Final project data.xlsx), so no working directory configuration is needed.
   
