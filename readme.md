# **U.S. Agricultural Trade Patterns and Trends - README**

## **1. Introduction**

### **1.1 Background**

This project explores U.S. **agricultural trade patterns and trends** using historical trade data spanning from **1975 to 2024**. By leveraging **time series forecasting techniques**, the study provides insights into **market volatility, seasonal variations, and global trade dynamics**. The findings aim to assist policymakers, stakeholders, and economists in making **data-driven decisions** related to trade planning and economic policy.

### **1.2 Objectives**

- Forecast U.S. **agricultural exports** using **advanced time series models**.
- Identify **seasonal patterns** in agricultural trade.
- Analyze the impact of **exogenous variables** (imports) on trade forecasting.
- Provide **recommendations** for strategic trade planning and economic policies.

---

## **2. Dataset Description and Structure**

### **2.1 Dataset Source**

The dataset used in this project is sourced from the **USDA ERS - U.S. Agricultural Trade Data Update**, compiled by the **Economic Research Service of the U.S. Department of Agriculture**.

### **2.2 Dataset Features**

| Column Name  | Description |
|-------------|------------|
| `Year`   | Year of record (1975 - 2024). |
| `Month`  | Monthly trade record. |
| `Exports` | U.S. agricultural exports (in USD). |
| `Imports` | U.S. agricultural imports (in USD). |
| `Trade Balance` | Net exports (Exports - Imports). |

- **Data spans 50 years (1975 - 2024).**
- **Monthly granularity** ensures detailed trend analysis.
- Data preprocessing included **log transformations, differencing, and seasonal decomposition**.

---

## **3. Exploratory Data Analysis (EDA)**

### **3.1 Data Exploration**

- **No missing values** were found, ensuring data integrity.
- **Exports and Imports exhibit strong seasonality**, influenced by **agricultural cycles** and **global demand**.
- **Trade balance fluctuates significantly**, highlighting the impact of **market shifts and policy changes**.

### **3.2 Data Transformations**

- **Log Transformation:** Applied to stabilize variance and remove heteroscedasticity.
- 
- **Seasonal Differencing:** Performed to make the series stationary for time series modeling.
- **Decomposition:** Used to separate data into **trend, seasonality, and residual components**.

### **3.3 Seasonal Trends**

- **Exports increase sharply from March to September**, followed by a decline and a **rise in November-December**.
- **Long-term growth observed** in exports, but seasonal fluctuations persist.
- **Economic events, weather conditions, and policy changes influence seasonal peaks.**

---

## **4. Methodology and Model Building**

### **4.1 SARIMA Model**

- **SARIMA (Seasonal Autoregressive Integrated Moving Average)** was used for time series forecasting.
- Steps:
  - **ACF and PACF analysis** to determine seasonal dependencies.
  - **Ljung-Box Test** to evaluate residual randomness.
  - **AIC/BIC criteria** for optimal model selection.
  - **Hyperparameter tuning** to enhance model accuracy.

### **4.2 SARIMA with Exogenous Variables (SARIMA-EXO)**

- **Incorporates imports as an external predictor**, improving forecast accuracy.
- **Better alignment with real-world trade dynamics**, allowing policymakers to evaluate the effect of import fluctuations on export forecasts.

### **4.3 Model Selection and Validation**

| Model | AIC | BIC | RMSE |
|--------|------------|--------|-----------|
| SARIMA (1,1,1)(2,1,5)[12] | 312.5 | 320.7 | 579M |
| **SARIMA-EXO** | **298.2** | **306.1** | **420M** |

- **SARIMA-EXO reduced error metrics (RMSE, MAE) significantly.**
- **Model validation tests confirmed stationarity and good predictive performance.**

---

## **5. Results and Key Insights**

### **5.1 Key Findings**

- **Long-term export growth observed, but seasonal effects remain dominant.**
- **SARIMA-EXO model improved forecast accuracy by incorporating imports.**
- **Significant seasonality in trade, with peaks in mid-year and late-year exports.**
- **Trade balance fluctuations highlight economic and policy-driven impacts.**
- **Exports and imports exhibit interdependencies, supporting the inclusion of exogenous variables in forecasting.**

### **5.2 Visual Insights**


---

## **6. Recommendations**

### **6.1 Business and Policy Implications**

- **Implement AI-driven trade forecasting models** to assist policymakers in planning agricultural exports.
- **Leverage insights from seasonal trends** to adjust production and trade strategies.
- **Incorporate exogenous factors such as economic indicators and weather patterns** for enhanced forecasting accuracy.
- **Develop contingency plans for market volatility** to safeguard against trade imbalances.

### **6.2 Future Work**

- **Incorporate additional exogenous variables** such as commodity prices, exchange rates, and foreign demand.
- **Explore deep learning models (LSTMs, Transformer models)** for time series forecasting.
- **Extend analysis to include policy-driven scenario forecasting.**

---

## **7. Conclusion**

This study demonstrates the **effectiveness of SARIMA-based forecasting models** in predicting **U.S. agricultural exports**. By incorporating **exogenous variables**, the predictive capability improves significantly, offering valuable insights for **trade planning and policy-making**. Future work should focus on **integrating economic indicators and advanced AI models** for enhanced trade forecasting.
