# twilio-segment-aws

**REQUIREMENT** : Before creating AWS services, first time creating IAM Role for Twilio Segment. Read this documentation for create IAM Role for Twilio Segment : https://segment.com/docs/connections/storage/catalog/aws-s3/#create-an-iam-role-in-the-aws-console

- **aws-glue** : explains about AWS Glue such as data catalog (database and table), crawler, data integration and ETL jobs.
- **amazon-redshift** : explains about Amazon Redshift such as receive result from ETL jobs of AWS Glue, query several table and Redshift ML feature with Amazon SageMaker.
- **amazon-sagemaker** : explains about Amazon SageMaker notebook such as generate dataset `train.csv` and `test.csv`, send from Python Server `test.csv` to Twilio Segment, integration between Redshift-Amazon S3 to CSV and send from Python Server `test_result.csv` amd `test_result_10.csv` to Twilio Segment.

**IMPORTANT NOTE** : After using all the services above, so turn off and delete all previously created services (AWS Glue, Amazon Redshift, Amazon SageMaker, Amazon S3 and Amazon VPC) because AWS is a paid service and to avoiding charge.
