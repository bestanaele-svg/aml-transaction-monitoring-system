-- Database schema for AML & Fraud Transaction Monitoring System

-- =========================
-- CUSTOMERS
-- =========================

CREATE TABLE customers (
    customer_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    full_name TEXT NOT NULL,
    risk_rating TEXT NOT NULL CHECK (risk_rating IN ('LOW','MEDIUM','HIGH')),
    created_at TIMESTAMPTZ DEFAULT NOW()
);


-- =========================
-- ACCOUNTS
-- =========================

CREATE TABLE accounts (
    account_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    customer_id BIGINT REFERENCES customers(customer_id),
    status TEXT NOT NULL CHECK (status IN ('ACTIVE','INACTIVE')),
    account_type TEXT NOT NULL CHECK (account_type IN ('CHEQUING','SAVINGS','INVESTMENT')),
    opened_at DATE
);


-- =========================
-- TRANSACTIONS
-- =========================

CREATE TABLE transactions (
    tx_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    account_id BIGINT REFERENCES accounts(account_id),
    credit_debit_indicator TEXT NOT NULL CHECK (credit_debit_indicator IN ('credit','debit')),
    channel TEXT NOT NULL CHECK (channel IN ('ATM','OTC','ONLINE')),
    tx_type TEXT NOT NULL CHECK (tx_type IN ('WIRE','CASH','TRANSFER','CHEQUE','POS')),
    amount NUMERIC(12,2) NOT NULL,
    tx_time TIMESTAMPTZ NOT NULL,
    device_id TEXT
);


-- =========================
-- ALERTS
-- =========================

CREATE TABLE alerts (
    alert_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    account_id BIGINT REFERENCES accounts(account_id),
    alert_type TEXT NOT NULL,
    domain TEXT NOT NULL CHECK (domain IN ('AML','FRAUD')),
    severity TEXT NOT NULL CHECK (severity IN ('LOW','MEDIUM','HIGH','CRITICAL')),
    alert_date DATE NOT NULL,
    total_amount NUMERIC(12,2) NOT NULL,
    status TEXT DEFAULT 'OPEN'
);


-- =========================
-- CASES
-- =========================

CREATE TABLE cases (
    case_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    alert_id BIGINT UNIQUE REFERENCES alerts(alert_id),
    case_type TEXT NOT NULL,
    priority TEXT NOT NULL CHECK (priority IN ('LOW','MEDIUM','HIGH')),
    status TEXT DEFAULT 'OPEN',
    created_at TIMESTAMPTZ DEFAULT NOW()
);
