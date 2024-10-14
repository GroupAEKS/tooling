terraform {
  required_version = ">=0.12.0"
  backend "s3" {
    key            = "env/terraform.state"
    bucket         = "teama-bucket-001"
    region         = "us-west-2"
    dynamodb_table = "teama-db-001"
  }
}
#