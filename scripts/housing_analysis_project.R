#Conor McCaffery
#Housing Supply & Price Analysis


library(readxl)
library(urca)
df <- read_excel("data/housing_macrohistory_data.xlsx",sheet="Macrohistory")
#df <- subset(df,select=-c(iso,ifs,JSTtrilemmaIV,rent_ipolated,eq_capgain_interp,eq_tr_interp))#The eq columns have missing data
df <- df[, colSums(is.na(df)) == 0]
lm(medprice~avg_new_housing,data=df) #hpnom = house price(nominal index, 1990=100)

#summary of data - Data section of final paper
mean(df$medprice) 
mean(df$avg_new_housing)
plot(df$year,df$avg_new_housing) #FIGURE 1
plot(df$avg_new_housing,df$medprice)#FIGURE 2
plot(df$year,df$medprice) #FIGURE 3
cor(df$year,df$medprice)
cor(df$avg_new_housing,df$medprice) #Correlation
#testing for stationary time series
adf_test <- ur.df(df$medprice,type="trend",lags=0)
summary(adf_test)

#lasso regression to drop redundant variables
library(glmnet)
#lasso <- glmnet(x=df,y=df$hpnom,alpha=1,na.rm=T)

data <- df[, -which(names(df) == "medprice")]
# Fit Lasso regression model
lasso_model <- cv.glmnet(as.matrix(data), df$medprice, alpha = 1)  # alpha = 1 for Lasso
# Select the optimal lambda value using cross-validation
best_lambda <- lasso_model$lambda.min
# Extract coefficients for the selected lambda
coefficients <- coef(lasso_model, s = best_lambda)
# Identify variables with non-zero coefficients
selected_variables <- which(coefficients != 0)


#selecting variables that reveal the current economic conditions
ols_model <- lm(medprice~avg_new_housing+gdp+cpi+ca+expenditure+tbus+money+iy+unemp+wage+housing_rent_rtn,data=df)
library(stargazer)
stargazer(ols_model,type="text")
#confidence intervals 
confint(ols_model)
ols_predictions <- predict(ols_model,interval="confidence",level=0.95)
ols_predicted_values <- ols_predictions[,"fit"]
lower_bound <- ols_predictions[,"lwr"]
upper_bound <- ols_predictions[,"upr"]
plot(df$avg_new_housing,df$medprice,col="blue",xlab="New Housing",ylab="OLS Predicted Values With CI") #OLS CI PLOT
abline(ols_model,col="red")

#Comparing the rate of change of hpnom of 1968 - 2007, to 2008-2020. 
#Predict future years.
AROC_before <-(244950-24800)/(2007-1968)
AROC_after <- (336950-244400)/(2020-2012) #medprice = 244400 in 2012. Figure 5 has an increasing trend in 2012-2020.
AROC_before
AROC_after

#predicting median home prices from regression model:
library(forecast)
tsdat <- ts(df$medprice,start=1968,frequency = 1)
plot(tsdat,main="Median Sales Price Over Time",xlab="Year",ylab="Median Home Price")
#fitting an ARIMA model
fit <- auto.arima(tsdat)

#fitting a pre-recession ARIMA model:
tsdat <- ts(df$medprice,start=1968,frequency = 1)
pre_recession_data <- window(tsdat,end=c(2007,12)) #pre-recession period ending at December 2007
ARIMA_pre_rec <- auto.arima(pre_recession_data)
summary(ARIMA_pre_rec)
library(forecast)
pre_rec_forecast <- forecast(ARIMA_pre_rec,h=39) #number of periods = 39 years between 1968 and 2007
plot(pre_rec_forecast) #FIGURE 4
#Constructing a confidence interval of ARIMA coefficients
coef_estimates <- coef(ARIMA_pre_rec)
coef_standard_errors <- sqrt(diag(vcov(ARIMA_pre_rec)))
z_scores <- qnorm(0.975)
lower_bounds <- coef_estimates - z_scores * coef_standard_errors
upper_bounds <- coef_estimates + z_scores * coef_standard_errors
plot(coef_estimates, type = "b", pch = 16, xlab = "Coefficient Index", ylab = "Coefficient Estimate",
     main = "ARIMA Coefficient Estimates with 95% Confidence Intervals") #Figure 5
#model diagnosis
arima_residuals <- residuals(ARIMA_pre_rec)
plot(arima_residuals,type="l",xlab="Time",ylab="Residuals",main="Residuals Plot of Pre-Recession ARIMA Model") #FIGURE 6

#Generating forecast
forecast <- forecast(fit,h=12) #forecasting for the next 12 years
plot(forecast, main = "Forecasted Median Home Prices", xlab = "Year", ylab = "Median Price") #FIGURE 7
#accuracy(forecast)
# Extract predicted median house prices for 2021, 2022, and 2023
predicted_prices <- forecast$mean[1:3]
predicted_prices

#Training set and test set to compare predicted time-series regression model with observed values.
training_size <- floor(0.8*nrow(df))
train_set <- df[1:training_size,]
test_set <-df[(training_size+1):nrow(df),]
model <- lm(medprice~avg_new_housing+gdp+cpi+ca+expenditure+tbus+money+iy+unemp+wage+housing_rent_rtn,data=train_set)
predictions <- predict(model,newdata=test_set)
library(Metrics)
mae <- mae(test_set$medprice, predictions)
rmse <- rmse(test_set$medprice, predictions)
plot(test_set$medprice, predictions, xlab = "Observed Values", ylab = "Predicted Values", main = "Observed vs Predicted") #FIGURE 8
abline(0, 1, col = "red")
mae
rmse

#trying a regression with first differences and lagged differences to get an unbiased estimator
library(dynlm)
library(stargazer)
tsdata <- ts(data=df,start=1968)
fd_reg <- dynlm(d(medprice)~d(avg_new_housing),data=tsdata) #Linear regression with first differences
ld_reg <- dynlm(d(medprice)~d(avg_new_housing)+L(d(avg_new_housing))+L(d(avg_new_housing),2),data=df)#Linear regression with lagged differences
stargazer(fd_reg,ld_reg,type="text")



#estimating parameters with an ARIMA model
library(forecast)
ts_data <- ts(df$medprice, start = 1968, frequency = 1)
arimax_model <- auto.arima(ts_data)
summary(arimax_model)
