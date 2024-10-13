terraform {
  required_version = ">=0.12.0"
  backend "s3" {
    key            = "tooling/terraform.state"
    bucket         = "groupa-buck-001"
    region         = "us-west-2"
    dynamodb_table = "groupa-tablelock-001"
  }
}
