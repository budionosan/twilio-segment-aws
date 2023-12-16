CREATE SCHEMA onlineloan;

CREATE TABLE onlineloan.train (
  loan_id varchar(50),
  loan_amount integer,
  loan_term integer,
  credit_score integer,
  income integer,
  employment_status varchar(50),
  purpose_loan varchar(50),
  property_ownership varchar(50),
  approval_status integer
);

COPY onlineloan.train
FROM 's3://datapalooza-budionosan/train.csv'
IAM_ROLE 'YOUR_IAM_ROLE_FOR_REDSHIFT' --example : arn:aws:iam::YOUR_AWS_ACCOUNT_ID:role/service-role/AMAZON_REDSHIFT_ROLE_NAME
DELIMITER ','
CSV
IGNOREHEADER 1
REGION 'us-east-2';

CREATE TABLE onlineloan.test (
  event varchar(50),
  originaltimestamp varchar(50),
  email varchar(50),
  name varchar(50),
  phone_number integer,
  credit_score integer,
  employment_status varchar(50),
  income integer,
  loan_amount integer,
  loan_term integer,
  property_ownership varchar(50),
  purpose_loan varchar(50),
  type varchar(50),
  userid varchar(50)
);