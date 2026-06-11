# Housing-Supply-Analysis-Project

## Project Overview
This repository contains a comprehensive quantitative research project analyzing the effect of housing supply growth on domestic home values in the United States from 1968 to 2020. This research was conducted in the 2024 Winter Quarter as part of my Advanced Quantitative Methods coursework at the University of California, Santa Cruz (UCSC).  

The primary objective of this analysis is to determine how changes in new housing construction affect median sales prices, utilizing both historical regression and predictive forecasting

## Business Values & Economic Insights
- Macro-Factors Outweigh Pure Supply: Discovered that macroeconomic variables—specifically the investment-to-GDP ratio, wages, and CPI are much stronger determinants of median home prices than the volume of new construction alone.
* The Economic Growth Indicator: While initial basic models suggested that increased supply lowers prices, controlling for broader economic indicators revealed a positive correlation. This suggests that high construction volume serves as an indicator of broader economic growth, which drives up demand and, in turn, prices.
+ Forecasting Limitations in Volatile Markets: Demonstrated that an ARIMA model trained on pre-recession data significantly underestimated the 2021-2023 housing market surge, highlighting the difficulty of forecasting during unprecedented economic destabilization like the COVID-19 pandemic.

## Data & Technical Stack
- Tools Used: R for statistical testing (including Augmented Dickey-Fuller tests) and predictive modeling
* Methodology: Ordinary Least Squares (OLS) regression, ARIMA (Autoregressive Integrated Moving Average) time-series forecasting, and Lasso regression for variable selection and handling multicollinearity.
+ Dataset: A subset of United States housing data from 1968-2023, combining new housing construction data (Sebastian Kohl et al., 2021) with median quarterly sales prices from the Federal Reserve.

## Quantitative Results & Model Performance

### Exploratory Data Analysis & Statistics
**Sample Mean** The baseline sample average housing price across the analyzed period was $149,530.20.
**Time Correlation** Median sales prices demonstrated a near-perfect positive correlation with time (years), showing a coefficient of 0.98.
**Stationarity Testing:** An Augmented Dickey-Fuller (ADF) test yielded a p-value of 0.035. This successfully rejected the null hypothesis of non-stationarity at the 95% significance level.

### OLS Regression Outcomes
**Base vs. Controlled Supply Impact:** A simple linear regression run solely on average new housing construction produced a negative coefficient estimate of -1218. However, after introducing critical macroeconomic controls (e.g., wages, unemployment, CPI), the relationship reversed to a statistically significant positive coefficient of 88.614.
**Model Fit:** The multivariate OLS model achieved an exceptionally high R-squared value of 0.998.
**Predictive Limitation:** When used as a forecasting tool with an 80/20 train-test split, the OLS model struggled, yielding a high Root Mean Square Error (RMSE) of 48,280.58.

### ARIMA Time-Series Forecasting
**Model Specification:** The pre-recession data was fitted to an ARIMA model, resulting in an AR1 coefficient of 1.37. The MA1 coefficient resulted in -0.80.
**Forecast Accuracy:** The ARIMA model proved significantly more reliable for time-series prediction than OLS, predicting post-recession median home prices with a much lower RMSE of $6,520.60.
