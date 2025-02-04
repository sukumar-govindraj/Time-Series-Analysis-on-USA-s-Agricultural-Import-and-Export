library(fpp3)

# Load and preprocess the data
temp = readr::read_csv("C:/Users/Chugu/Documents/FALL 24/Times Series/New folder/data.csv")

# Convert the dataset into a tsibble
TradeData <- temp %>%
  mutate(Date = yearmonth(paste(Year, Month))) %>%  # Combine numeric Year and Month into a Date column
  as_tsibble(index = Date)                         # Set Date as the time index

# Clean and preprocess the data
TradeData <- TradeData %>%
  mutate(
    Exports = as.numeric(gsub(",", "", Exports)),
    Imports = as.numeric(gsub(",", "", Imports)),
    `Trade balance` = as.numeric(gsub(",", "", `Trade balance`))
  ) %>%
  select(-Year, -Month)  # Drop the Year and Month columns

str(TradeData)

# Visualize initial trends
TradeData %>%
  autoplot(Exports)

TradeData %>%
  autoplot(Imports)

TradeData %>%
  autoplot(`Trade balance`)

# Filter training data until sept 2023
train_data <- TradeData %>% filter(Date <= yearmonth("2023-09"))

# Calculate lambda for transformations
lambda_exports <- train_data %>% features(Exports, guerrero) %>% pull(lambda_guerrero)
lambda_imports <- train_data %>% features(Imports, guerrero) %>% pull(lambda_guerrero)
lambda_trade_balance <- train_data %>% features(`Trade balance`, guerrero) %>% pull(lambda_guerrero)


# Visualize transformed data
train_data %>% autoplot(log(Exports))

# Conduct stationarity tests 
# Non-seasonal differencing requirements
train_data %>% features(log(Exports), unitroot_ndiffs)

# Seasonal differencing requirements
train_data %>% features(log(Exports), unitroot_nsdiffs)

# Apply required differencing for stationarity
train_data <- train_data %>%
  mutate(
    Exports_differenced = difference(log(Exports), lag = 12) %>% difference()
  )

# Visualize ACF and PACF for differenced data
train_data %>%
  gg_tsdisplay(Exports_differenced, lag_max = 30, plot_type = "partial") +
  labs(title = "ACF and PACF for Differenced Exports")

# Combine model guesses with mandatory seasonal components
all_models <- train_data %>%
  model(
    SARIMA110 = ARIMA(log(Exports) ~ 0 + pdq(1, 1, 0) + PDQ(1, 1, 0)),
    SARIMA012 = ARIMA(log(Exports) ~ 0 + pdq(1, 1, 0) + PDQ(0, 1, 2)),
    SARIMA215 = ARIMA(log(Exports) ~ 0 + pdq(1, 1, 1) + PDQ(2, 1, 5)),
    SARIMA212 = ARIMA(log(Exports) ~ 0 + pdq(0, 1, 2) + PDQ(2, 1, 2)),
    SARIMA112 = ARIMA(log(Exports) ~ 0 + pdq(1, 1, 2) + PDQ(2, 1, 2)),
    AutoSARIMA = ARIMA(log(Exports))  # Automatic model as a benchmark
  )
#library(urca)
# Compare all models using AIC and BIC
all_models_summary <- all_models %>%
  glance() %>%
  as.data.frame() %>%
  select(.model, AIC, BIC)

# Print AIC and BIC comparison
print(all_models_summary)

# Define the SARIMA215 model
SARIMA215_model <- train_data%>%
  model(SARIMA215 = ARIMA(Exports ~ 0 + pdq(1, 1, 1) + PDQ(2, 1, 5)))

# Report the model to check parameter estimates and diagnostics
SARIMA215_model %>%
  report()

# Residual diagnostics: Plot residuals
SARIMA215_model %>%
  gg_tsresiduals(lag_max = 12) +
  labs(title = "Residual Diagnostics for SARIMA215 Model")

# Perform Ljung-Box test to evaluate residuals for randomness
SARIMA215_model %>%
  augment() %>%
  features(.innov, ljung_box, lag = 12, dof = 9)


# Forecast the SARIMA215 model
SARIMA215_forecast <- SARIMA215_model %>%
  forecast(h = "24 months")  # Forecast for 12 monts (sep 2023 to sep 2024)

# Plot the forecast and actual data
SARIMA215_forecast %>%
  autoplot(filter_index(TradeData, "2021 Jan" ~ .))


# Calculate the accuracy of the forecast
SARIMA215_accuracy <- SARIMA215_forecast %>%
  accuracy(data = TradeData) %>%  # Compare forecast with actual data in TradeData
  select(.model, ME, RMSE, MAE, MAPE) %>%  
  as.data.frame()  

# Print the accuracy metrics
print(SARIMA215_accuracy)

#SARIMA MODEL WITH EXOGENOUS VARIABLE

sarima_exo_model <- train_data %>%
  model(
    SARIMA_EXO = ARIMA(log(Exports) ~ 0 + box_cox(Imports, lambda_imports) + pdq(1, 1, 1) + PDQ(2, 1, 5))
  )

# Check model performance
sarima_exo_model %>%
  report()

# Plot residual diagnostics
sarima_exo_model %>%
  augment() %>%
  gg_tsdisplay(.resid, lag_max = 30, plot_type = "partial") +
  labs(title = "Residual Diagnostics for SARIMA with Exogenous Variable")



model_Imports <- train_data %>%
  model(ARIMA(Imports))

fore_Imports <- model_Imports %>%
  forecast(h = 24)  # Forecast Imports for 24 months

# Generate future data for forecasting
future_data <- new_data(train_data, 24) %>%
  mutate(
    Imports = fore_Imports$.mean  # Use forecasted Imports values
  )

# Forecast Exports using SARIMA with Exogenous Variable
sarima_exo_forecast <- sarima_exo_model %>%
  forecast(new_data = future_data)

# Plot the forecast
sarima_exo_forecast %>%
  autoplot(TradeData %>% filter_index("2020 Jan" ~ "2025 Sep"), level = NULL) +
  labs(
    title = "SARIMA with Exogenous Variable (Imports) Forecast for Exports",
    y = "Exports"
  )


# Compare SARIMA with and without exogenous variables
sarima_models <- train_data %>%
  model(
    BASE = ARIMA(log(Exports) ~ 0 + pdq(1, 1, 1) + PDQ(2, 1, 5)),
    EXO = ARIMA(log(Exports) ~ 0 + lag(box_cox(Imports, lambda_imports)) + 
                  pdq(1, 1, 1) + PDQ(2, 1, 5))
  )

# Forecast both models
combined_forecast <- sarima_models %>%
  forecast(new_data = future_data)

# Plot forecasts from both models
combined_forecast %>%
  autoplot(TradeData %>% filter_index("2020 Jan" ~ "2025 Sep"), level = NULL) +
  labs(
    title = "Comparison of SARIMA with and without Exogenous Variable",
    y = "Exports"
  )

# Accuracy metrics for both models
sarima_accuracy <- combined_forecast %>%
  accuracy(data = TradeData) %>%
  select(.model, ME, RMSE, MAE, MAPE) %>%
  as.data.frame()

print(sarima_accuracy)


