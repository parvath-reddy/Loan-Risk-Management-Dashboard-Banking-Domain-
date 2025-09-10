# Loan Risk Management Dashboard (Banking Domain)

##  Project Overview
This project focuses on **Loan Risk Analytics in the Banking sector**.  
The goal was to understand how banks can **minimize lending risks** by analyzing customer data, evaluating engagement, and monitoring financial transactions.

By cleaning and transforming messy data into structured insights, I built an **end-to-end pipeline** that starts from raw banking data and ends with a **Power BI interactive dashboard** for decision-making.

---
Loan-Risk-Management/
│
├── README.md               # Project overview, screenshots, insights
├── data/                   # Datasets
│   └── Banking.csv         # Cleaned dataset
│
├── notebooks/              # Jupyter Notebook
│   └── BankRiskManagement.ipynb
│
├── sql/                    # SQL scripts
│   └── queries.sql         # Schema + cleaning + KPI queries
│
├── powerbi/                # Power BI files
│   ├── dashboard.pbix      # Power BI file (if small enough)
│   └── screenshots/        # Dashboard screenshots (png/jpg)
│
└── docs/                   # Reports & presentation
    ├── Banking_Report.docx
    └── Banking_Presentation.pptx
    

## 🏦 Problem Statement
Banks often face risks of loan defaults when lending to customers.  
The objective of this project was:
- To analyze **clients’ financial behavior** (deposits, loans, credit, savings).  
- To create a system that helps banks **decide loan approval risks** using **data-driven insights**.  

---

## 📊 Dataset
The dataset contained multiple interconnected tables:
- **Clients & Banking Relationship**
- **Gender Information**
- **Investment Advisors**
- **Period Records**

Data challenges:
- Redundant tables and inconsistent formats  
- Missing values & unstructured relationships  

---

##  Data Cleaning
Performed in **Excel, SQL & Python (Jupyter Notebook)**:
- Merged multiple tables into a single cleaned dataset.  
- Created new calculated fields:  
  - **Engagement Timeframe & Engagement Days** (client relationship duration).  
  - **Income Band** (Low < 100K, Mid < 300K).  
  - **Processing Fees** based on fee structures.  
- Standardized column formats and handled missing values.  

---

##  Tools & Tech Stack
- **Excel** → Initial cleaning & exploration.  
- **SQL (MySQL)** → Database storage, queries, and cleaned table creation.  
- **Python (Jupyter Notebook)** → Data exploration, Pandas, Matplotlib, Seaborn visualizations.  
- **Power BI** → Final dashboards, KPIs, and DAX measures.  

---

##  Power BI Dashboards
Built a set of interactive dashboards tracking key **Banking KPIs**:

### KPIs Used:
-  **Total Clients** = 3000
-  **Total Loan** = 4.38bn  
-  **Total Deposits** = $111.49M  
-  **Total Fees** = $3.77bn


### Key Dashboards:
1. **Loan Analysis Dashboard**
   - Loan distribution by **income band** and **nationality**  
   - Identified high-risk client groups  

2. **Deposit Analysis Dashboard**
   - Trends in deposits by account type (savings, checking, foreign currency)  

3. **Engagement & Relationship Insights**
   - Impact of client engagement duration on loan risk  

4. **Summary Dashboard**
   - Combined KPIs for quick decision-making  

---

## DAX Measures
Examples of calculated functions:
- `Total Clients = DISTINCTCOUNT(Client ID)`
- `Total Loan = SUM(Bank Loan + Business Lending + Credit Card Balance)`
- `Engagement Days = DATEDIFF(Joined Bank, TODAY(), DAY)`
- `Total Fees = SUMX([Total Loan] * Processing Fees)`

---

##  Insights
- **High-income bands** showed higher loan volumes but lower risk per client.  
- **Private banks** attracted more clients compared to government banks.  
- **Nationalities analysis** revealed which groups hold the largest bank loans.  
- **Engagement time** strongly influenced client loyalty and repayment reliability.  

---

##  Conclusion
This project highlights how **data-driven dashboards empower banks** to make better decisions:  
- Minimize **loan default risks**  
- Improve **client targeting & retention strategies**  
- Gain transparency into **financial KPIs**  

---



## 🧑‍💻 Author
**T. Parvath Reddy**  
📌 Portfolio Project | Data Analytics & BI  
