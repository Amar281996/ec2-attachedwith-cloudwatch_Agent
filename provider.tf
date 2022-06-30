# provider details on which plant form we want to provision these resources
terraform {
    required_providers {
        aws = {
        source = "hashicorp/aws"
    }
   }
}
provider "aws" {
    region = "us-east-1"
    profile = "default"
}
