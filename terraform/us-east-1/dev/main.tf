
provider "aws" {
  profile = var.profile
  region  = var.region
  default_tags {
    tags = {
      Environment = var.env
      Project     = "avantio"
    }
  }

}

terraform {
  backend "s3" {
    bucket         = "dev-us-east-1-avantio-terraform-state"
    dynamodb_table = "dev-us-east-1-avantio-terraform-lock"
    key            = "dev/terraform.tfstate"
    region         = "us-east-1"
  }

}

