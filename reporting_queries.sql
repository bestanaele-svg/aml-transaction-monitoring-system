-- Reporting queries for dashboard and monitoring
-- These queries support alert, case, and risk reporting


-- =========================
-- ALERT MONITORING
-- =========================

-- Total alerts by alert type
SELECT
    alert_type,
    COUNT(*) AS total_alerts
FROM alerts
GROUP BY alert_type
ORDER BY total_alerts DESC;


-- Alerts by severity
SELECT
    severity,
    COUNT(*) AS alert_count
FROM alerts
GROUP BY severity
ORDER BY alert_count DESC;


-- Alerts by status
SELECT
    status,
    COUNT(*) AS total_alerts
FROM alerts
GROUP BY status
ORDER BY total_alerts DESC;


-- Alerts by domain
SELECT
    domain,
    COUNT(*) AS total_alerts
FROM alerts
GROUP BY domain
ORDER BY total_alerts DESC;


-- Alerts over time
SELECT
    alert_date,
    COUNT(*) AS total_alerts
FROM alerts
GROUP BY alert_date
ORDER BY alert_date;


-- Total alert amount by domain
SELECT
    domain,
    SUM(total_amount) AS total_alert_amount
FROM alerts
GROUP BY domain
ORDER BY total_alert_amount DESC;


-- =========================
-- CASE MONITORING
-- =========================

-- Open cases by priority
SELECT
    priority,
    COUNT(*) AS open_cases
FROM cases
WHERE status = 'OPEN'
GROUP BY priority
ORDER BY open_cases DESC;


-- Cases by status
SELECT
    status,
    COUNT(*) AS total_cases
FROM cases
GROUP BY status
ORDER BY total_cases DESC;


-- Cases created over time
SELECT
    DATE(created_at) AS case_date,
    COUNT(*) AS total_cases
FROM cases
GROUP BY DATE(created_at)
ORDER BY case_date;


-- =========================
-- RISK SUMMARY
-- =========================

-- Top risky accounts by alert count
SELECT
    account_id,
    COUNT(*) AS total_alerts
FROM alerts
GROUP BY account_id
ORDER BY total_alerts DESC
LIMIT 10;


-- High severity alerts by account
SELECT
    account_id,
    COUNT(*) AS high_severity_alerts
FROM alerts
WHERE severity IN ('HIGH', 'CRITICAL')
GROUP BY account_id
ORDER BY high_severity_alerts DESC
LIMIT 10;
