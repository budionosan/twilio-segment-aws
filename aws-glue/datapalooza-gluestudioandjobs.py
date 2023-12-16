import sys
from awsglue.transforms import *
from awsglue.utils import getResolvedOptions
from pyspark.context import SparkContext
from awsglue.context import GlueContext
from awsglue.job import Job
from awsglue import DynamicFrame

args = getResolvedOptions(sys.argv, ["JOB_NAME"])
sc = SparkContext()
glueContext = GlueContext(sc)
spark = glueContext.spark_session
job = Job(glueContext)
job.init(args["JOB_NAME"], args)

# Script generated for node AWS Glue Data Catalog
aws_glue_data_catalog = glueContext.create_dynamic_frame.from_catalog(
    database="datapalooza-glue",
    table_name="1701129600000",
    transformation_ctx="aws_glue_data_catalog",
)

# Script generated for node Change Schema
change_schema = ApplyMapping.apply(
    frame=aws_glue_data_catalog,
    mappings=[
        ("event", "string", "event", "string"),
        ("originaltimestamp", "string", "originaltimestamp", "string"),
        ("properties.email", "string", "email", "string"),
        ("properties.name", "string", "name", "string"),
        ("properties.phone_number", "int", "phone_number", "int"),
        ("properties.credit_score", "int", "credit_score", "int"),
        ("properties.employment_status", "string", "employment_status", "string"),
        ("properties.income", "int", "income", "int"),
        ("properties.loan_amount", "int", "loan_amount", "int"),
        ("properties.loan_id", "string", "loan_id", "string"),
        ("properties.loan_term", "int", "loan_term", "int"),
        ("properties.property_ownership", "string", "property_ownership", "string"),
        ("properties.purpose_loan", "string", "purpose_loan", "string"),
        ("type", "string", "type", "string"),
        ("userid", "string", "userid", "string"),
    ],
    transformation_ctx="change_schema",
)

# Script generated for node Amazon Redshift
amazon_redshift = glueContext.write_dynamic_frame.from_jdbc_conf(
    frame=change_schema,
    connection_options = {"dbtable": "onlineloan.test", "database": "dev"}, 
	 redshift_tmp_dir = args["TempDir"],
    catalog_connection = "gluedatacatalogtoredshift",
    transformation_ctx = "amazon_redshift",
)

job.commit()