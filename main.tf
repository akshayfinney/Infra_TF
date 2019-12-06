# Define provider and region
# The credentials should be located in your user path
# Create 

provider "aws" {
    region                  = "us-west-2"
    shared_credentials_file = "/Users/akshayfinney/.aws/credentials"
    profile                 = "mfa"
    assume_role {
     role_arn  = "arn:aws:iam::367805628163:role/TIQ_Admin"
    }
}

resource "aws_instance" "testservice" {
    ami         = "${data.aws_ami.ubuntu.id}"
    instance_type = "t2.micro"
    tags = {
    Name = "textiqtest"
    }
    tags = {
        Terraform   = "true"
        Environment = "dev"
    }
}

# Adding S3 Bucket backend to store TF-Statefiles
resource "aws_s3_bucket" "tfstate" {
  bucket = "tf-dev-state"
  acl    = "private"

  tags = {
    Name        = "tfstate"
    Environment = "Dev"
  }
}

