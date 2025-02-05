# **U.S. Agricultural Trade Patterns and Forecasting**

## **Project Overview**
This project analyzes **U.S. agricultural trade data from 1975 to 2024** to identify patterns, trends, and seasonal effects in exports. Using **time series forecasting models**, we predict future export trends, helping policymakers and stakeholders make data-driven decisions.

## **Objective of the Analysis**
The primary goal is to **forecast U.S. agricultural exports** while addressing challenges such as:
- **Market volatility**
- **Seasonal variations**
- **Global trade dynamics**

This analysis provides actionable insights to **improve trade planning, market demand forecasting, and economic policy formulation**.

---

## **Dataset Information**
- **Source:** U.S. Department of Agriculture (USDA) Economic Research Service
- **Time Frame:** 1975 - 2024
- **Data Variables:** Year, Imports, Exports, Trade Balances
- **Format:** Monthly raw trade data (unadjusted for seasonality)
  
![image](https://github.com/user-attachments/assets/a644b0aa-c7c8-4d56-bf0a-945efb5e9711)

---

## **Project Workflow**
![image](https://github.com/user-attachments/assets/8f0e2ed3-634b-462f-9c89-5aa19364ed2a)

1. **Exploratory Data Analysis (EDA):** Identifying trends, seasonality, and data inconsistencies.
2. **Data Pre-processing & Cleaning:** Handling missing values and applying transformations.
3. **Stationarity & Variance Stabilization:** Log and Box-Cox transformations.
4. **Model Building & Validation:** SARIMA and SARIMA-EXO models.
5. **Forecasting U.S. Agricultural Exports:** Evaluating different model performances.
6. **Insights & Business Implications:** Using forecasts for trade policies and decision-making.

---

## **Key Exploratory Data Analysis (EDA) & Insights**
### **1. Log Transformation (Before vs. After)**
- **Before:** The raw export data had high variance and strong seasonal fluctuations.
- ![image](https://github.com/user-attachments/assets/278ffa46-782e-4658-ad25-3e90f642bb26)

- **After:** Log transformation stabilized variance, making trends easier to analyze.
![image](https://github.com/user-attachments/assets/e3103da5-1a3b-494c-8427-4861e4c36386)

📌 *Key Takeaway:* **Log transformation improves model accuracy by reducing the impact of extreme values.**

### **2. Export Variable Decomposition**
![image](https://github.com/user-attachments/assets/388c261a-60ca-40fd-96ce-286c9e359eb6)

- **Trend:** Exports increased over time, with occasional economic/geopolitical disruptions.
- **Seasonality:** Regular cycles indicate strong seasonal effects.
- **Residuals:** Unexplained variations that may be driven by external factors.

📌 *Key Takeaway:* **Seasonal fluctuations in agricultural exports align with global harvesting cycles.**

### **3. Seasonal Patterns Over the Years**
![image](https://github.com/user-attachments/assets/86323721-6b9c-4b61-ad8a-27f93276cf5a)

- **Exports peak between March and September, drop slightly, then rise again in November-December.**
- **The magnitude of exports has grown significantly over time.**

📌 *Key Takeaway:* **Trade seasonality is linked to agricultural production cycles and global demand shifts.**

### **4. Model Building - SARIMA Analysis**
![image](https://github.com/user-attachments/assets/f81515a8-6739-4d8c-bd4b-9575350a166c)

- **Autocorrelation Function (ACF):** Seasonal peaks confirm **annual seasonality**.
- **Partial Autocorrelation Function (PACF):** Indicates autoregressive components in the model.
- **Ljung-Box Test:** Residual analysis confirms minimal correlation, ensuring model reliability.

📌 *Key Takeaway:* **SARIMA captures export seasonality and trends effectively.**

### **5. Model Selection Using AIC & BIC**
- **Best model:** **SARIMA(1,1,1)(2,1,5)[12]**
- **AIC & BIC criteria:** The model achieves the lowest scores while balancing complexity and accuracy.
![image](https://github.com/user-attachments/assets/793b3dcb-df22-404f-866f-0d58b4974d8b)

📌 *Key Takeaway:* **The SARIMA(1,1,1)(2,1,5) model provides the best trade forecasts.**

### **6. SARIMA With Exogenous Variable (Imports)**
![image](https://github.com/user-attachments/assets/c0892d8b-b788-479d-84c1-30e47a04bbc1)
- **Imports variable after box-cox transformation.**
- **Imports used as an external predictor to improve forecast accuracy.**
- **SARIMA-EXO model performed better than base SARIMA.**
- ![image](https://github.com/user-attachments/assets/9410286a-77da-4c43-8d9d-770af57818c8)

- **Reduces error metrics:**
  - Mean Absolute Error (MAE): **Reduced from 435M to 420M**
  - Root Mean Square Error (RMSE): **Dropped from 592M to 579M**

📌 *Key Takeaway:* **Adding imports as an exogenous variable enhances forecasting accuracy.**

### **7. Forecasting Results & Business Implications**
- **Predictions show a modest increase in exports over the next year.**
- **Impact on policymakers:**
  - Should firms expand production facilities?
  - How will this affect food inflation?
  - Will there be supply chain adjustments?

📌 *Key Takeaway:* **Accurate forecasting supports economic planning and trade policy adjustments.**

---

## **Conclusion**
- **SARIMA modeling effectively captures trade trends and seasonality.**
- **The SARIMA-EXO model further improves accuracy using external predictors.**
- **Insights from this study help policymakers anticipate trade fluctuations and make informed decisions.**

### **Next Steps:**
✅ Implement additional exogenous variables like exchange rates and commodity prices.
✅ Explore deep learning models for more robust long-term forecasting.
✅ Conduct **real-time policy impact analysis** based on trade projections.

--

📌 *Best suited for:* **Data analysts, economists, and policymakers looking to leverage data-driven trade forecasting.**

---

## **Acknowledgment**
This project was submitted as part of **ASDS 5306 - Applied Time Series Analysis** at the **University of Texas at Arlington** under **Dr. Shan Sun Mitchelle**.

📌 *For any queries or suggestions, feel free to reach out!* 🚀

