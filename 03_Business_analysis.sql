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