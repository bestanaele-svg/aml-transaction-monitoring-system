-- Detection rules for AML and Fraud alert generation

-- =========================
-- AML RULES
-- =========================

-- Rule 1: Cash Structuring
-- Detects multiple cash deposits under $10,000 that exceed $20,000 in one day

INSERT INTO alerts (
    account_id,
    alert_type,
    alert_date,
    total_amount,
    domain,
    severity,
    status
)
SELECT
    account_id,
    'Cash Structuring',
    DATE(tx_time) AS alert_date,
    SUM(amount) AS total_amount,
    'AML' AS domain,
    'HIGH' AS severity,
    'OPEN' AS status
FROM transactions
WHERE tx_type = 'CASH'
  AND credit_debit_indicator = 'credit'
  AND amount < 10000
GROUP BY account_id, DATE(tx_time)
HAVING SUM(amount) > 20000;

-- =========================
-- FRAUD RULES
-- =========================

-- Rule 2: Account Takeover / New Device Large Debit
-- Flags large debit transactions from a device not previously seen on the account

INSERT INTO alerts (
    account_id,
    alert_type,
    alert_date,
    total_amount,
    domain,
    severity,
    status
)
SELECT
    t.account_id,
    'ATO - New Device Large Debit',
    DATE(t.tx_time) AS alert_date,
    t.amount AS total_amount,
    'FRAUD' AS domain,
    'HIGH' AS severity,
    'OPEN' AS status
FROM transactions t
WHERE t.credit_debit_indicator = 'debit'
  AND t.amount >= 2000
  AND NOT EXISTS (
      SELECT 1
      FROM transactions old_tx
      WHERE old_tx.account_id = t.account_id
        AND old_tx.device_id = t.device_id
        AND old_tx.tx_time < t.tx_time
  );
