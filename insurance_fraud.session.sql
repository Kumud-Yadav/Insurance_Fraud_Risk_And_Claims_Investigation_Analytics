WITH claimant_history AS (
    SELECT claimant_id,
        COUNT(*) AS claim_count
    FROM claims
    GROUP BY claimant_id
),
risk_scoring AS (
    SELECT c.claim_id,
        c.claimant_id,
        c.claim_amount,
        c.claim_status,
        c.incident_type,
        c.weather_condition,
        c.police_report_filed,
        c.witnesses_count,
        c.is_fraud,
        CASE
            WHEN rp.fraud_history_flag = TRUE
            OR cp.fraud_history_flag = TRUE
            OR ap.fraud_history_flag = TRUE THEN 3
            ELSE 0
        END AS provider_risk,
        CASE
            WHEN c.police_report_filed = FALSE THEN 2
            ELSE 0
        END AS police_report_risk,
        CASE
            WHEN c.witnesses_count = 0 THEN 2
            ELSE 0
        END AS witness_risk,
        CASE
            WHEN c.claim_amount > 4008.06 THEN 1
            ELSE 0
        END AS claim_amount_risk,
        CASE
            WHEN ch.claim_count > 2 THEN 1
            ELSE 0
        END AS repeat_claim_risk
    FROM claims c
        LEFT JOIN providers rp ON c.repair_provider_id = rp.provider_id
        LEFT JOIN providers cp ON c.clinic_provider_id = cp.provider_id
        LEFT JOIN providers ap ON c.attorney_provider_id = ap.provider_id
        LEFT JOIN claimant_history ch ON c.claimant_id = ch.claimant_id
)
SELECT *,
    provider_risk + police_report_risk + witness_risk + claim_amount_risk + repeat_claim_risk AS fraud_risk_score
FROM risk_scoring
ORDER BY fraud_risk_score DESC;