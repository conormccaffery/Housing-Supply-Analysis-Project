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
