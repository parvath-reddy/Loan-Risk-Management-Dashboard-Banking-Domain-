-- ======================================================
-- Loan Risk Management Project - SQL Scripts
-- ======================================================

-- 1. Create Database
CREATE DATABASE IF NOT EXISTS loan_risk_db;
USE loan_risk_db;

-- 2. Create Table (structure based on Banking.csv)
DROP TABLE IF EXISTS clients_banking;

CREATE TABLE clients_banking (
    ClientID INT,
    GenderID INT,
    BRId INT,                      -- Banking Relationship ID
    IAId INT,                      -- Investment Advisor ID
    JoinedBank DATE,
    EstimatedIncome DECIMAL(15,2),
    BankLoans DECIMAL(15,2),
    BusinessLending DECIMAL(15,2),
    CreditCardBalance DECIMAL(15,2),
    BankDeposits DECIMAL(15,2),
    CheckingAccounts DECIMAL(15,2),
    SavingAccounts DECIMAL(15,2),
    ForeignCurrencyAccount DECIMAL(15,2),
    AmountOfCreditCards INT,
    FeeStructure VARCHAR(20),
    Nationality VARCHAR(50),
    RiskWeighting INT
);

-- 3. Load Data (adjust path as per your system)
-- Make sure 'secure_file_priv' allows file import
LOAD DATA INFILE '/path/to/Banking.csv'
INTO TABLE clients_banking
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- ======================================================
-- Feature Engineering
-- ======================================================

-- 4. Engagement Days (since client joined)
ALTER TABLE clients_banking ADD COLUMN EngagementDays INT;
UPDATE clients_banking
SET EngagementDays = DATEDIFF(CURDATE(), JoinedBank);

-- 5. Income Band
ALTER TABLE clients_banking ADD COLUMN IncomeBand VARCHAR(10);
UPDATE clients_banking
SET IncomeBand = CASE
    WHEN EstimatedIncome < 100000 THEN 'Low'
    WHEN EstimatedIncome < 300000 THEN 'Med'
    ELSE 'High'
END;

-- 6. Processing Fee (based on Fee Structure)
ALTER TABLE clients_banking ADD COLUMN ProcessingFee DECIMAL(5,2);
UPDATE clients_banking
SET ProcessingFee = CASE
    WHEN FeeStructure = 'High' THEN 0.05
    WHEN FeeStructure = 'Med'  THEN 0.03
    ELSE 0.01
END;

-- 7. Total Loan per Client
ALTER TABLE clients_banking ADD COLUMN TotalLoan DECIMAL(15,2);
UPDATE clients_banking
SET TotalLoan = IFNULL(BankLoans,0) + IFNULL(BusinessLending,0) + IFNULL(CreditCardBalance,0);

-- 8. Total Deposit per Client
ALTER TABLE clients_banking ADD COLUMN TotalDeposit DECIMAL(15,2);
UPDATE clients_banking
SET TotalDeposit = IFNULL(BankDeposits,0) + IFNULL(CheckingAccounts,0) + IFNULL(SavingAccounts,0) + IFNULL(ForeignCurrencyAccount,0);

-- ======================================================
-- KPI Queries
-- ======================================================

-- 9. Total Unique Clients
SELECT COUNT(DISTINCT ClientID) AS TotalClients
FROM clients_banking;

-- 10. Total Loan Book
SELECT SUM(TotalLoan) AS TotalLoanBook
FROM clients_banking;

-- 11. Total Deposits
SELECT SUM(TotalDeposit) AS TotalDeposits
FROM clients_banking;

-- 12. Total Credit Card Accounts & Balance
SELECT SUM(AmountOfCreditCards) AS TotalCreditCards,
       SUM(CreditCardBalance) AS TotalCreditCardBalance
FROM clients_banking;

-- 13. Estimated Total Fees
SELECT SUM(TotalLoan * ProcessingFee) AS EstimatedTotalFees
FROM clients_banking;

-- ======================================================
-- Analytical Queries (for Power BI)
-- ======================================================

-- 14. Loan distribution by Income Band
SELECT IncomeBand, SUM(TotalLoan) AS LoanByBand
FROM clients_banking
GROUP BY IncomeBand
ORDER BY LoanByBand DESC;

-- 15. Loan distribution by Nationality
SELECT Nationality, SUM(TotalLoan) AS LoanByNationality
FROM clients_banking
GROUP BY Nationality
ORDER BY LoanByNationality DESC;

-- 16. Average Engagement by Risk Weighting
SELECT RiskWeighting, AVG(EngagementDays) AS AvgEngagementDays
FROM clients_banking
GROUP BY RiskWeighting;

-- 17. Deposit vs Loan ratio per client
SELECT ClientID, TotalLoan, TotalDeposit,
       ROUND(TotalLoan / NULLIF(TotalDeposit,0), 2) AS LoanDepositRatio
FROM clients_banking
LIMIT 20;

-- 18. Top 10 Clients by Loan Exposure
SELECT ClientID, TotalLoan, IncomeBand, Nationality
FROM clients_banking
ORDER BY TotalLoan DESC
LIMIT 10;

-- ======================================================
-- End of Script
-- ======================================================
