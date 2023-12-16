# AWS Glue

1. Go to AWS Glue console, click `Data Catalog` -> `Databases` -> `Add database`. Fill the database name and click `Create database`.

2. Click your database name -> `Add tables using crawler`. Fill the crawler name, Data Source is NO and click `Add a data source`.

3. Choose S3 for data source. Location of S3 data - in this account. Click `Browse S3` then search your S3 bucket that store Segment Logs until find number objects example : `1711129500000/`, click bullet and click `Choose`. Choose `Crawl all sub-folders` and click `Add an S3 data source` -> `Next`.

4. Click `Create new IAM role`. Fill the IAM role for AWS Glue name then click `Create` -> `Next`.

5. Choose your database and crawler schedule is on-demand. Click `Next`. Then click `Create crawler`.

6. Click `Run crawler`. Waiting until Status is Completed. Click `Tables` like this screenshot : Integration between Amazon S3 and AWS Glue using Crawler.png. Your table is now available.

7. Click your table, click `Edit schema`. You see Schema Before Cleaning and Schema After Cleaning image in this AWS Glue section repository.

# AWS Glue Studio

1. Click `Data Catalog` -> `Connections`. Click `Create connection` -> choose `Amazon Redshift`. Choose your Amazon Redshift cluster. Database name and username automatically available. Input your password of database and click `Next`. Change name to `gluedatacatalogtoredshift` and click `Create connection`. Then click `Edit` -> fill your password again -> click `Network options - optional`. Choose your VPC that connected with your Amazon Redshift cluster. Choose subnet and security groups -> click `Save changes`.

2. Click `Data Integration and ETL` -> `ETL Jobs` -> `Visual ETL`. Follow instruction based AWS Glue Jobs on AWS Glue Studio.png . For Amazon Redshift data target, you ensure your Redshift cluster is available so that schema and table is automatically showing. Click `Performance and security` -> choose your IAM Role for AWS Glue that already created before.

3. Click `Script` -> `Edit script` -> `Confirm`. Delete all code and change (copy-paste) datapalooza-gluestudioandjobs.py to script.
**NOTE** : Ensure you check again your database name and your table name of AWS Glue Data Catalog, your connection_options and your catalog_connection of Amazon Redshift.

4. Click `Job details`. Choose your IAM Role for AWS Glue. Request number of workers - change to 3. Click `Advanced properties` scroll find `Connections` and choose your connections.

5. Click `Save` -> `Run` -> `Runs`. Waiting until Succeeded. Open the Amazon Redshift console in a new tab (don't close the AWS Glue page) then click your cluster and click `Query data` -> `Query in query editor v2` for ensure your result of ETL jobs table is now available. Click your table, test with `SELECT * FROM <your-table>;` and click `Run` for got result of query.

**NOTE** : 
If you got error/job runs that failed (see Challenge.png image), the solution are is create VPC endpoint. Open the VPC console in a new tab (don't close the AWS Glue page) -> `Endpoints`, in Services write s3 then choose `com.amazonaws-<your_AWS_Region>.s3` then choose Gateway type. Choose your VPC that connected with your Amazon Redshift cluster. Checklist all route tables. Ensure policy is Full access and click `Create endpoint`. Back to `Runs`, click Refresh icon then click again `Run` until Succeeded (see ETL Job is Successful.png image).
