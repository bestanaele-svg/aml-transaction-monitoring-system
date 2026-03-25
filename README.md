# AML-Transaction-Monitoring-System
SQL project simulating an AML &amp; fraud transaction monitoring system (alerts → cases workflow)

## Overview

This project simulates a transaction monitoring system used by financial institutions to detect suspicious activity, generate alerts, and escalate cases. Built using SQL and PostgreSQL, it replicates AML and fraud detection workflows through data modeling, rule-based logic, and reporting. Developed as part of my transition from AML QA into AML technology.

## System Architecture
Customers → Accounts → Transactions → Alerts → Cases

This mirrors how real transaction monitoring systems operate in banking and fintech environments.

## Detection Logic

### 🔴 Cash Structuring (AML)
Detects multiple cash deposits under $10,000 that exceed $20,000 within a single day.

### 🔵 Account Takeover (Fraud)
Flags large debit transactions from new/unrecognized devices.

## Sample Detection Query (AML Structuring)

```sql
SELECT
  account_id,
  DATE(tx_time) AS tx_date,
  SUM(amount) AS total_amount
FROM transactions
WHERE tx_type = 'CASH'
  AND credit_debit_indicator = 'credit'
  AND amount < 10000
GROUP BY account_id, DATE(tx_time)
HAVING SUM(amount) > 20000;
```

## SQL Concepts Demonstrated 
- Relational schema design  
- Primary & foreign keys  
- Aggregations (SUM, COUNT, GROUP BY)  
- HAVING for rule detection  
- Subqueries (NOT EXISTS)  
- CASE WHEN logic

## Business Relevance
This project demonstrates how financial institutions:
- Detect suspicious activity  
- Prioritize high-risk alerts  
- Support investigation workflows

## Tech Stack
- SQL  
- PostgreSQL  
- Power BI

## Full Documentation
[View Full Project PDF](AML_Financial_Crime_Monitoring_System_Portfolio_pdf)

## About Me
AML professional with experience in transaction monitoring and QA, transitioning into AML technology and fintech.
Interested in financial crime systems, risk analytics, and data-driven detection.
