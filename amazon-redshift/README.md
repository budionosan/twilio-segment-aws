# Amazon Redshift

**REQUIREMENT** : Before create Redshift cluster, you must create VPC : https://docs.aws.amazon.com/redshift/latest/mgmt/getting-started-cluster-in-vpc.html

1. Go to Amazon Redshift console, click `Configurations` -> `Subnet groups`. Fill the cluster subnet group name and description. Choose your VPC then click `Add all the subnets for this VPC` and click `Create cluster subnet group`.
   
2. For create Amazon Redshift cluster, read this documentation : https://docs.aws.amazon.com/redshift/latest/gsg/rs-gsg-launch-sample-cluster.html .

**NOTE** : Node type - dc2.large. Number of nodes - 1. Don't checklist load sample data. Choose `Manually add the admin password` and input password. Choose `Any Amazon S3 bucket`. Turn off Use defaults. Click `Network and security`, choose your VPC, security group and cluster subnet group. Checklist Turn on Publicly accessible.

3. Ensure your IAM Role for Amazon Redshift like IAM Role for Amazon Redshift.png . Click your Redshift cluster, click `Properties` then click your IAM role to automatically open new tab. If several policy is not available, click `Add permissions` -> `Attach policies` then write policy name and checklist the policy name. Click `Add permissions` and new policy is added. This IAM role important because several policy can using Amazon Redshift ML feature.

4. Back to your Redshift cluster, click `Query data` -> `Query in query editor v2` automatically open a new tab. Click your Redshift cluster, show pop-up connect to your cluster. Choose `Temporary credentials using a database user name` then input your user name. Click `Create connection` and automatically your database `dev` is now available. Click `dev`. 

5. Click **+** icon for add editor OR notebook. Create schema `onlineloan`. Create table `onlineloan.train` then copy from Amazon S3 `train.csv`. Also create table `onlineloan.test`. You can following the SQL syntax **onlineloan.sql**.

6. Open the AWS Glue console in a new tab (don't close the Redshift page) then go to AWS Glue README.md : https://github.com/budionosan/twilio-segment-aws/tree/main/aws-glue for explain process Result of Segment Logs in Amazon S3 be processes to AWS Glue for crawler, create data catalog and ETL jobs from AWS Glue Data Catalog to Amazon Redshift that used for `onlineloan.test` table.

7. After got result of query from `onlineloan.test` table, back to Redshift query editor v2, query table `onlineloan.train` and `onlineloan.test` for analysis and dashboard. You can following the SQL syntax **query.sql**. You can also try other query according to these two data.

8. Create Redshift ML model for can predict approval_status in `onlineloan.test` table with following the SQL syntax **redshiftml.sql**. 

**NOTE** : This model runs approximately 1 hour 30 minutes because I forgot to add the MAX_RUNTIME settings from default (5400) to 1800. If MAX_RUNTIME was 1800, this model would run faster. 

**NOTE** : Amazon Redshift ML feature connected with Amazon SageMaker. Open the Amazon SageMaker console in a new tab (don't close the Redshift page), check and click `Processing` -> `Processing jobs`, `Training` -> `Training jobs` -> `Hyperparameter tuning jobs`, `Inference` -> `Compilation jobs` -> `Batch transform jobs` -> `Models`. For specifically `Models`, you can **DELETED** all model that now running if you already **CREATE TABLE** `onlineloan.test_result` because if `Models` is not deleted, always on and be charged until deleted. 

9. Open the Amazon S3 console in a new tab (don't close the Redshift page), click your bucket then create 2 folder. Click `Create folder` with name `result_redshift_onlineloan_test` and `result_redshift_onlineloan_test_10` . Back to Redshift query editor v2, you can following the SQL syntax **afterredshiftml.sql**.

10. Go to Amazon SageMaker README.md : https://github.com/budionosan/twilio-segment-aws/tree/main/amazon-sagemaker then follow no. 4 **redshift_to_s3_to_csv.ipynb** and no. 5 **test_result_to_segment.ipynb** file.
