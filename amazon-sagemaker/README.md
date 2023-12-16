# Amazon SageMaker

Read this documentation for create Amazon SageMaker notebook : https://docs.aws.amazon.com/sagemaker/latest/dg/howitworks-create-ws.html

1. **generate_train_dataset.ipynb** : generate train dataset using Pandas, Numpy and uuid. Have 10000 rows and 9 columns (loan_id, loan_amount, loan_term, credit_score, income, employment_status, purpose_loan, property_ownership, approval_status). For approval_status, 70% approved (1) and 30% denied (0). Save to CSV file `train.csv`. `train.csv` be download to local and uploaded to Amazon S3 for COPY to Amazon Redshfit `onlineloan.train` table.

2. **generate_test_dataset.ipynb** : generate test dataset using Pandas, Numpy, uuid, random and string. Have 900 rows and 11 columns (loan_id, name, email, phone_number, loan_amount, loan_term, credit_score, income, employment_status, purpose_loan, property_ownership). This test dataset **DOES NOT HAVE** approval_status. Save to CSV file `test.csv`.

3. **python_to_segment.ipynb** : Install and import Python source. Using CSV file from generate test dataset `test.csv`. Send **identify user**, track **Sign Up Account** and track **Send Loan Proposal** based `test.csv` data to Twilio Segment and transfer to Amazon S3 for development.  Result of Segment Logs in Amazon S3 be processes to AWS Glue for crawler, create data catalog and ETL jobs from AWS Glue Data Catalog to Amazon Redshift that used for `onlineloan.test` table. Explained in AWS Glue README.md : https://github.com/budionosan/twilio-segment-aws/tree/main/aws-glue

**redshift_to_s3_to_csv.ipynb** and **test_result_to_segment.ipynb** used after the process in Amazon Redshift is complete, README.md : https://github.com/budionosan/twilio-segment-aws/tree/main/amazon-redshift

4. **redshift_to_s3_to_csv.ipynb** : After export `onlineloan.test_result` and `onlineloan.test_result_10` table to Amazon S3 with CSV format (https://github.com/budionosan/twilio-segment-aws/blob/main/amazon-redshift/afterredshiftml.sql), got .csv data from S3 that already created by query of Amazon Redshift. Using Pandas and Boto3 (AWS SDK for Python). Read CSV file from Amazon S3. Assign default column names (loan_amount, loan_term, credit_score, income, employment_status, purpose_loan, property_ownership, approval_status, loanplusinsight (for test_result_10 only)). Save to CSV file `test_result.csv` and `test_result_10.csv`.

5. **test_result_to_segment.ipynb** : Install and import Python source. Using CSV file from `test_result.csv` and `test_result_10.csv`. Send track **Get Approved Loan Notification** based `test_result.csv` and track **Pay Loan + Interest** based `test_result_10.csv` data to Twilio Segment.

- **train.csv , test.csv , test_result.csv and test_result_10.csv** : Example of CSV data.

**NOTE** : `train.csv` is loans data history. `test.csv` is borrower data. `test_result.csv` mean .csv data have approval_status based prediction from Redshift ML. `test_result_10.csv` mean .csv data about 10% borrower pay loan + interest.
