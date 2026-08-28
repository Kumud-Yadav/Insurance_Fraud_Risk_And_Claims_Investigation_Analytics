-- 1. ROW COUNT VALIDATION
SELECT 'claims' AS table_name,
    COUNT(*) AS row_count
FROM claims
UNION ALL
SELECT 'claimants',
    COUNT(*)
FROM claimants
UNION ALL
SELECT 'vehicles',
    COUNT(*)
FROM vehicles
UNION ALL
SELECT 'providers',
    COUNT(*)
FROM providers;
-- 2. CHECK FOR DUPLICATE CLAIM IDs
SELECT claim_id,
    COUNT(*) AS duplicate_count
FROM claims
GROUP BY claim_id
HAVING COUNT(*) > 1;
-- 3. CHECK FOR DUPLICATE CLAIMANT IDs
SELECT claimant_id,
    COUNT(*) AS duplicate_count
FROM claimants
GROUP BY claimant_id
HAVING COUNT(*) > 1;
-- 4. CHECK FOR DUPLICATE VEHICLE IDs
SELECT vehicle_id,
    COUNT(*) AS duplicate_count
FROM vehicles
GROUP BY vehicle_id
HAVING COUNT(*) > 1;
-- 5. CHECK FOR DUPLICATE PROVIDER IDs
SELECT provider_id,
    COUNT(*) AS duplicate_count
FROM providers
GROUP BY provider_id
HAVING COUNT(*) > 1;
-- 6. CLAIMS → CLAIMANTS RELATIONSHIP
SELECT COUNT(*) AS missing_claimants
FROM claims c
    LEFT JOIN claimants cl ON c.claimant_id = cl.claimant_id
WHERE c.claimant_id IS NOT NULL
    AND cl.claimant_id IS NULL;
-- 7. CLAIMS → VEHICLES RELATIONSHIP
SELECT COUNT(*) AS missing_vehicles
FROM claims c
    LEFT JOIN vehicles v ON c.vehicle_id = v.vehicle_id
WHERE c.vehicle_id IS NOT NULL
    AND v.vehicle_id IS NULL;
-- 8. CLAIMS → CLINIC PROVIDERS
SELECT COUNT(*) AS missing_clinic_providers
FROM claims c
    LEFT JOIN providers p ON c.clinic_provider_id = p.provider_id
WHERE c.clinic_provider_id IS NOT NULL
    AND p.provider_id IS NULL;
-- 9. CLAIMS → REPAIR PROVIDERS
SELECT COUNT(*) AS missing_repair_providers
FROM claims c
    LEFT JOIN providers p ON c.repair_provider_id = p.provider_id
WHERE c.repair_provider_id IS NOT NULL
    AND p.provider_id IS NULL;
-- 10. CLAIMS → ATTORNEY PROVIDERS
SELECT COUNT(*) AS missing_attorney_providers
FROM claims c
    LEFT JOIN providers p ON c.attorney_provider_id = p.provider_id
WHERE c.attorney_provider_id IS NOT NULL
    AND p.provider_id IS NULL;
-- 11. CHECK NULL VALUES IN IMPORTANT CLAIM FIELDS
SELECT COUNT(*) FILTER (
        WHERE claim_id IS NULL
    ) AS missing_claim_id,
    COUNT(*) FILTER (
        WHERE claimant_id IS NULL
    ) AS missing_claimant_id,
    COUNT(*) FILTER (
        WHERE vehicle_id IS NULL
    ) AS missing_vehicle_id,
    COUNT(*) FILTER (
        WHERE claim_amount IS NULL
    ) AS missing_claim_amount,
    COUNT(*) FILTER (
        WHERE is_fraud IS NULL
    ) AS missing_fraud_flag
FROM claims;
-- 12. CHECK FRAUD FLAG VALUES
SELECT is_fraud,
    COUNT(*) AS claim_count
FROM claims
GROUP BY is_fraud
ORDER BY is_fraud;
-- 13. CHECK NEGATIVE CLAIM AMOUNTS
SELECT COUNT(*) AS negative_claim_amounts
FROM claims
WHERE claim_amount < 0;
-- 14. CHECK NEGATIVE PAYOUT AMOUNTS
SELECT COUNT(*) AS negative_payout_amounts
FROM claims
WHERE payout_amount < 0;
-- 15. CHECK CLAIM STATUS VALUES
SELECT claim_status,
    COUNT(*) AS claim_count
FROM claims
GROUP BY claim_status
ORDER BY claim_count DESC;