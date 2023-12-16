SELECT * FROM dev.onlineloan.test_result;

SELECT * FROM dev.onlineloan.test_result WHERE approval_status = 1 ORDER BY RANDOM() LIMIT 90; --because 10% from 900 already pay loan + interest 

--create new table - onlineloan.test_result_10
CREATE TABLE onlineloan.test_result_10 AS SELECT loan_id, loan_amount, loan_term, credit_score, income, employment_status, purpose_loan, property_ownership, approval_status, loan_amount + (loan_amount * 0.1) AS loanplusinterest
FROM dev.onlineloan.test_result WHERE approval_status = 1 ORDER BY RANDOM() LIMIT 90; --because 10% from 900 already pay loan + interest 

SELECT * FROM dev.onlineloan.test_result_10;

--export onlineloan.test_result table to Amazon S3 with CSV format
UNLOAD ('SELECT * FROM dev.onlineloan.test_result')
TO 's3://datapalooza-budionosan/result_redshift_onlineloan_test/' 
IAM_ROLE 'YOUR_IAM_ROLE_FOR_REDSHIFT' --example arn:aws:iam::YOUR_AWS_ACCOUNT_ID:role/service-role/YOUR_AMAZON_REDSHIFT_ROLENAME
CSV
PARALLEL OFF;

--export onlineloan.test_result_10 table to Amazon S3 with CSV format
UNLOAD ('SELECT * FROM dev.onlineloan.test_result_10')
TO 's3://datapalooza-budionosan/result_redshift_onlineloan_test_10/' 
IAM_ROLE 'YOUR_IAM_ROLE_FOR_REDSHIFT' --example arn:aws:iam::YOUR_AWS_ACCOUNT_ID:role/service-role/YOUR_AMAZON_REDSHIFT_ROLENAME
CSV
PARALLEL OFF;