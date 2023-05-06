provider "aws" {
  region = "us-west-2"
}

resource "aws_s3_bucket" "raw_data" {
  bucket = "raw-data-bucket"
}

resource "aws_s3_bucket" "curated" {
  bucket = "curated-data-bucket"
}

resource "aws_db_instance" "postgresql" {
  engine         = "postgres"
  instance_class = "db.t3.micro"
  name           = "mydb"
  username       = "myuser"
  password       = "mypassword"
  allocated_storage = 20
  skip_final_snapshot = true
}

module "mongodb" {
  source = "terraform-aws-modules/rds/aws"

  identifier = "mongodb"

  engine         = "mongodb"
  engine_version = "4.0.3"
  instance_class = "db.t3.medium"
  allocated_storage = 20
  name           = "mydb"
  username       = "myuser"
  password       = "mypassword"
  skip_final_snapshot = true
}

resource "aws_redshift_cluster" "redshift" {
  cluster_identifier = "redshift-cluster"
  database_name   = "redshift"
  master_username = "masteruser"
  master_password = "masterpassword"
  node_type       = "dc2.large"
  cluster_type    = "single-node"
  skip_final_snapshot = true
}

resource "aws_glue_catalog_database" "aws_glue_catalog" {
  name = "aws_glue_catalog"
}

resource "aws_glue_connection" "aws_glue_redshift_connection" {
  name = "aws_glue_redshift_connection"

  connection_properties = {
    PASSWORD = "masterpassword"
    USERNAME = "masteruser"
    CONNECTION_URL = "jdbc:redshift://${aws_redshift_cluster.redshift.endpoint}/redshift"
  }

  physical_connection_requirements {
    availability_zone      = "us-west-2a"
    security_group_id_list = ["sg-123456"]
    subnet_id              = "subnet-123456"
  }
}