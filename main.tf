terraform {
   required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.69"
    }
  }

  backend "s3" {
    bucket         = "express-terraform-s3-terraform-state"
    key            = "express-terraform-s3.tfstate"
    region         = "us-east-1"
    dynamodb_table = "express-terraform-s3-terraform-state-lock"
    encrypt        = true
  }

  required_version = ">= 1.9.6"
}

provider "aws" {
  region = "us-east-1"
  default_tags {
    tags = {
      env     = "env"
      project = "project"
      owner   = "terraform"
      tfstate = "express-terraform-s3"
    }
  }
}

resource "aws_instance" "app_server" {
  ami           = "ami-0e54eba7c51c234f6"
  instance_type = "t2.micro"

  tags = {
    Name = "ExampleAppServerInstance"
  }
}

