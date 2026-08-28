/*
 WORK IN PROGRESS
 */
-- What is the overall fraud performance?
SELECT count (*) as total_claims,
    sum(is_fraud) as fraudulent_claims,
    round(
        sum(is_fraud)::NUMERIC * 100 / count(*),
        2
    ) as fraud_rate,
    round(sum(claim_amount), 2) as total_claim_amount,
    round(
        sum(
            CASE
                WHEN is_fraud = 1 then claim_amount
                ELSE 0
            END
        ),
        2
    ) As fraudulent_claims_amount
from claims;
-- Which claim statuses have the highest fraud rate?
SELECT claim_status,
    COUNT(*) AS total_claims,
    SUM(is_fraud) AS fraudulent_claims,
    ROUND(
        SUM(is_fraud)::NUMERIC / COUNT(*) * 100,
        2
    ) AS fraud_rate,
    ROUND(SUM(claim_amount), 2) AS total_claim_amount
FROM claims
GROUP BY claim_status
ORDER BY fraud_rate DESC;
-- Which types of incidents are most associated with fraudulent claims?
SELECT incident_type,
    COUNT(*) AS total_claims,
    SUM(is_fraud) AS fraudulent_claims,
    ROUND(
        SUM(is_fraud)::NUMERIC / COUNT(*) * 100,
        2
    ) AS fraud_rate,
    ROUND(SUM(claim_amount), 2) AS total_claim_amount
FROM claims
GROUP BY incident_type
ORDER BY fraud_rate DESC;
-- Does weather condition influence the likelihood of a fraudulent claim?
SELECT weather_condition,
    COUNT(*) AS total_claims,
    SUM(is_fraud) AS fraudulent_claims,
    round(SUM(is_fraud)::NUMERIC / COUNT(*) * 100, 2) as fraud_rate,
    ROUND(SUM(claim_amount), 2) AS total_claim_amount
FROM claims
GROUP BY weather_condition
ORDER BY fraud_rate DESC;
-- Are claims without a police report more likely to be fraudulent?
SELECT police_report_filed,
    COUNT(*) AS total_claims,
    SUM(is_fraud) AS fraudulent_claims,
    round(SUM(is_fraud)::NUMERIC / COUNT(*) * 100, 2) as fraud_rate,
    ROUND(SUM(claim_amount), 2) AS total_claim_amount
FROM claims
GROUP BY police_report_filed
ORDER BY fraud_rate DESC;
-- Does the number of witnesses correlate with fraud risk?
SELECT witnesses_count,
    COUNT(*) AS total_claims,
    SUM(is_fraud) AS fraudulent_claims,
    ROUND(
        SUM(is_fraud)::NUMERIC / COUNT(*) * 100,
        2
    ) AS fraud_rate
FROM claims
GROUP BY witnesses_count
ORDER BY witnesses_count;
-- Is the number of reported injuries associated with higher fraud risk?
SELECT injuries_count,
    COUNT(*) AS total_claims,
    SUM(is_fraud) AS fraudulent_claims,
    ROUND(
        SUM(is_fraud)::NUMERIC / COUNT(*) * 100,
        2
    ) AS fraud_rate,
    ROUND(AVG(claim_amount), 2) AS average_claim_amount
FROM claims
GROUP BY injuries_count
ORDER BY injuries_count;