CREATE TABLE claims (
    claim_id VARCHAR(20),
    claimant_id VARCHAR(20),
    vehicle_id VARCHAR(20),
    clinic_provider_id VARCHAR(20),
    repair_provider_id VARCHAR(20),
    attorney_provider_id VARCHAR(20),
    incident_type VARCHAR(50),
    weather_condition VARCHAR(20),
    claim_date DATE,
    police_report_filed BOOLEAN,
    injuries_count INTEGER,
    witnesses_count INTEGER,
    claim_amount NUMERIC(12, 2),
    claim_status VARCHAR(30),
    payout_amount NUMERIC(12, 2),
    is_fraud INTEGER,
    fraud_ring_id VARCHAR(20),
    payout_ratio NUMERIC(10, 4),
    claim_year INTEGER,
    claim_month INTEGER,
    claim_month_name VARCHAR(20),
    unpaid_amount NUMERIC(12, 2)
);
CREATE TABLE public.claimants (
    claimant_id VARCHAR(20),
    name VARCHAR(100),
    gender VARCHAR(20),
    age INTEGER,
    marital_status VARCHAR(30),
    occupation VARCHAR(50),
    annual_income NUMERIC(12, 2),
    credit_score INTEGER,
    state VARCHAR(50),
    address VARCHAR(200),
    phone VARCHAR(30),
    bank_account_hash VARCHAR(100),
    policy_type VARCHAR(50),
    policy_tenure_years NUMERIC(5, 1),
    prior_claims_count INTEGER
);
CREATE TABLE public.vehicles(
    vehicle_id varchar(20),
    make varchar(20),
    model varchar(20),
    model_year INTEGER,
    vehicle_type varchar(50),
    fuel_type varchar(20),
    market_value NUMERIC (12, 2),
    vin_hash varchar(20)
);
CREATE TABLE public.providers(
    provider_id VARCHAR(20),
    provider_name VARCHAR(100),
    provider_type VARCHAR(50),
    state VARCHAR(50),
    years_in_business INTEGER,
    fraud_history_flag BOOLEAN
);