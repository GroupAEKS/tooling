variable "bucket" {
  description = "The name of the S3 bucket"
  type        = string
  default     = "groupa-buck-001"
}

variable "table" {
  description = "The name of the DynamoDB table"
  type        = string
  default     = "groupa-tablelock-001"
}

variable "region" {
  description = "The AWS region"
  type        = string
  default     = "us-west-2"
}
