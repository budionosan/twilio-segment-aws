--create Amazon Redshift ML model with name onlineloan_testresult from onlineloan.train table
CREATE MODEL onlineloan_testresult FROM (SELECT loan_amount, loan_term, credit_score, income, employment_status, purpose_loan, property_ownership, approval_status FROM dev.onlineloan.train) 
TARGET approval_status 
FUNCTION predict_approval_status
IAM_ROLE 'YOUR_IAM_ROLE_FOR_REDSHIFT' --example arn:aws:iam::YOUR_AWS_ACCOUNT_ID:role/service-role/YOUR_AMAZON_REDSHIFT_ROLENAME
SETTINGS (S3_BUCKET 'datapalooza-budionosan'); --can also add parameter MAX_RUNTIME 1800 in SETTINGS (better) , default MAX_RUNTIME 5400

SHOW MODEL onlineloan_testresult;

--predict approval status with onlineloan.test table 
SELECT loan_id, predict_approval_status(loan_amount, loan_term, credit_score, income, employment_status, purpose_loan, property_ownership) AS approval_status FROM dev.onlineloan.test WHERE loan_id IS NOT NULL;

--create new table - onlineloan.test_result with have approval_status
CREATE TABLE onlineloan.test_result AS SELECT loan_id , loan_amount, loan_term, credit_score, income, employment_status, purpose_loan, property_ownership, predict_approval_status(loan_amount, loan_term, credit_score, income, employment_status, purpose_loan, property_ownership) AS approval_status 
FROM dev.onlineloan.test WHERE loan_id IS NOT NULL; --total 900 rows

--after create new table, delete this ML model
DROP MODEL onlineloan_testresult;